//Minerva Purification (Light in the Darkness)
package classes.Scenes.Areas.HighMountains 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	
	public class MinervaPurification extends BaseContent
	{
		
		public function checkRathazul():Boolean {
			return (player.findStatusEffect(StatusEffects.CampRathazul) >= 0 || player.statusEffectv2(StatusEffects.MetRathazul) >= 3);
		}
		public function checkJojo():Boolean {
			return (player.findStatusEffect(StatusEffects.PureCampJojo) >= 0);
		}
		public function checkMarae():Boolean {
			return (flags[kFLAGS.FACTORY_SHUTDOWN] == 1 && flags[kFLAGS.MARAE_QUEST_COMPLETE] >= 1);
		}
		
		private function playerParentDesc(caps:Boolean = false):String {
			switch(player.gender) {
				case GENDER_NONE:
					if (caps) return player.mf("Mommy", "Daddy");
					else return player.mf("mommy", "daddy");
					break;
				case GENDER_MALE:
					if (caps) return "Daddy";
					else return "daddy";
					break;
				case GENDER_FEMALE:
					if (caps) return "Mommy";
					else return "mommy";
					break;
				case GENDER_HERM: //A bit wonky. I should consider the maleherms.
					if (caps) return "Mommy-Daddy";
					else return "mommy-daddy";
					break;
				default:
					return player.mf("mommy", "daddy");
			}
		}
		
		//Begin purification quest.
		public function startPurification():void {
			clearOutput();
			outputText("You had been thinking about what Minerva said the last time you talked to her. She had mentioned the source of her corruption and that it was the reason for her self imposed exile to her oasis. You gesture for Minerva to join you at the usual spot you take when talking, sitting by the spring on the soft pillowy moss. Clearly noticing your thoughtful expressing and desire to talk, Minerva pokes you gently in the side. \"<i>Hey, what's wrong? You're all lost in thought. Want to talk about it?</i>\" she asks, wondering just what it is that has you troubled so much.");
			
			outputText("\n\nNot sure exactly how to broach the subject you decide to tell her outright, putting a hand on her shoulder you tell the siren that you want to help her. Offering yourself to try and find a way to cure her and purify her body. The red-headed shark-like harpy breaks out into a bright toothy smile, showing off her jagged shark teeth before suddenly grabbing you and hugging you. ");
			
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] > 0) outputText("\n\nThe close contact and her over-stimulated libido causes her penis to erect itself and begin to press against your body, the harpy/harpies Minerva has kept her looking on with jealousy that she is paying attention to you and not them.");
			outputText("\n\nShe eagerly embraces you, nearly squeezing the life out of you with sheer enthusiasm. \"<i>You will? You really will? I can hardly believe that someone will actually help me.</i>\" she says, before wiping the start of a tear from her eye and grinning at you.");
			
			outputText("\n\n\"<i>Since you can leave this place and explore the world, you must have lots of experience with the world. Do you have any clues as to what we could use to cure me?</i>\" she asks you with excitement. It's a very good question, how are you going to help her?");
			
			//Pure Marae
			if (checkMarae() && !checkJojo() && !checkRathazul()) {
				outputText("\n\nYou remember that Marae still has her mind left, thanks to your efforts. She should be grateful enough to you to lend her help to the cause of saving Minerva, shouldn't she? You nod your head and explain your idea to her. You tell the siren that there is a goddess that can be found at the lake; since she is a goddess and has great and pure powers it is likely that she will be able to free her of her parasitic affliction.");
			
				outputText("\n\nUpon hearing of this goddess Minerva perks up, a hopeful look on her face. \"<i>Really? You're sure it's a goddess? I mean, if it's something like a goddess I'm sure she would be able to help,</i>\" she says with a small smile, hope glimmering in her eyes. \"<i>That's my dream. If there is any option you can pursue, I will help however I can. Though I wish I could leave this place and help you.</i>\" the hope-filled siren says, before gently hugging you for a while as an expression of her thanks. Looking the siren over you broach the question, asking her to why she can't come with you, surely there would be a way to safeguard her from the corruption.");

				outputText("\n\nMinerva looks to you with sad eyes. \"<i>I wish I could, really I do. This parasite, it constantly infuses its corrupting influence into me, which could be stemmed with a few things. But it's gotten into the routine of holding some back for a while before suddenly flooding me with it as if to try and overwhelm me. When it gets like that I have to get to the spring and immerse myself right away. So I can't stray too far from my home here, at best I can fly a short distance around the tower but that's as far as I dare go,</i>\" she says with regret clear in her voice. Looking away she hugs you again, burying her face into your shoulder and sighing, just wanting to hold you for now.");

				outputText("\n\nAfter a while you break the embrace; you would spend more time here, but you need to check up on camp as well as see about Marae as an option for a cure. On the other hand, you could tell her about some of the potions at your disposal, it could help give the unfortunate siren hope.");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
				flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 0;
				flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 0;
			}
			//Jojo Follower
			else if (!checkMarae() && checkJojo() && !checkRathazul()) {

				outputText("\n\nJojo has helped you overcome corruption before; maybe he can help Minerva? Nodding your head, you tell her about the mouse monk that lives in your camp with you. You speak about how Jojo has helped you curb and be freed of corruption before, and could likely help her as well, at the least he could probably help to calm her condition and teach her how to meditate and further repulse her corruption.");

				outputText("\n\nUpon hearing of your monk friend Minerva looks intrigued. Could a holy man like a monk really be able to help her? Would he have the ability to purge her corruption and exorcise the demon parasite from her body? The red-headed siren bites her lip gently before nodding in agreement. \"<i>It's definitely worth a try. It has to be of some help. Even if he just helps me keep my corruption in check, maybe It would be enough to let me leave the tower more often.</i>\" she says with at least a little hope in her voice. \"<i>I wish I could come with you to meet this monk, but I guess I'll see him soon enough, right?</i>\"");

				outputText("\n\nYou spend a bit more time with Minerva at the oasis, before reluctantly departing. After all you have to go and see Jojo about a cure as well as stopping the demon's spread");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
				flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 0;
				flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 0;
			}
			//Rathazul
			else if (!checkMarae() && !checkJojo() && checkRathazul()) {
				outputText("\n\nIt's a long shot, but Rathazul clearly knows something about alchemical purification; maybe he can devise a potion to at least kill the damn parasite inside your siren friend? Nodding your head, you inform Minerva about the alchemist that makes his home in your camp. You have seen him work and he knows a great deal about alchemy; perhaps he could create a potion of some kind.");

				outputText("\n\nDespite the soundness of the idea, Minerva seems nervous about it. Biting her lip, she tries her best to smile, clearly doubting how well a simple potion could solve her problems. After all, she's been infested by this thing for so long. \"<i>Well, I suppose it's worth a try, I mean if he is as good as you say he might be able to help... I mean, it can't make things any worse can it?</i>\"");

				outputText("\n\nYou assure her that Rathazul will come up with something to help, even if it just ends up killing the parasite inside her. \"<i>Well... if there are any ingredients around here, I'll gladly help you obtain them.</i>\" Minerva promises, still skeptical. After spending a little more time talking to the siren and reassuring her that Rathazul will be able to help, you depart for camp. After all, you need to find out what kinds of alchemical ingredients the rat-morph will need.");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
				flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 0;
				flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 0;
				flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 1;
			}

			//Pure Marae & Jojo Follower
			else if (checkMarae() && checkJojo() && !checkRathazul()) {
				outputText("\n\nJojo's spiritual powers might be able to help Minerva, but if he can't, you can always go to the source; even in her weakened condition, with the factory shut down, surely Marae's powers can heal Minerva? Excitedly, you tell Minerva about a few options you have for curing her. Hearing that you have a few different ideas brings a smile to her face, clearly happy to hear such promising news.");
				
				outputText("\n\nImmediately, you start to tell her about Marae and Jojo, going on to explain how you met both the mouse monk and the goddess of Mareth herself. At hearing some of your adventures, Minerva seems ever-more excited, hope glimmering in her eyes as you tell her about how grateful Marae was that you saved her. It's likely you gained a lot of favor with the goddess with your actions, perhaps enough for you to ask for her aid.");

				outputText("\n\nWhen you go into detail about Jojo the monk, she looks thoughtful, clearly thinking hard about the possible ways that he would be able to help. There is clearly potential in this option as well, as he could know some kind of exorcism ritual that could cleanse her body. \"<i>I think those are great options! We are fortunate that you have such allies and are such a strong and brave adventurer to carry the favor of a goddess!</i>\" she declares, before grabbing you and hugging you against her chest. \"<i>I am so happy that you stumbled across my tower! You have given me hope that I will one day have a bright future.</i>\" she tells you, before pecking you gently on the cheek.");

				outputText("\n\nYou spend a bit more time with the grateful siren by the pure spring, before reluctantly departing. After all you have much work to do; you have to talk to Marae and Jojo about healing Minerva. ");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
				flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 0;
			}
			//Pure Marae & Rathazul
			else if (checkMarae() && !checkJojo() && checkRathazul()) {
				outputText("\n\nMarae might be too weak to heal Minerva on her own, but she may be able to provide ingredients of some kind that Rathazul can use to create a potion that will do just as well. Excitedly, you tell Minerva about a few options you have for curing her. Hearing that you have a few different ideas brings a smile to her face, clearly happy to hear such promising news.");

				outputText("\n\nImmediately, you start to tell her about Marae and Rathazul, going on to explain how you met both the alchemical master and the goddess of Mareth herself. At hearing some of your adventures Minerva seems ever-more excited, hope glimmering in her eyes as you tell her about how grateful Marae was that you saved her. It's likely you gained a lot of favor with the goddess with your actions, perhaps enough for you to ask for her aid.");

				outputText("\n\nClearly your service to Rathazul has come in handy; having such an experienced alchemist at your service will pay off a great deal. Minerva, though looks, a little more unsure about it. Doubting that, after living with the parasite for so long, a simple potion could cure her, even though there are many unique materials and plants in the world and so perhaps some combination could at least put an end to the foul creature inside her. \"<i>These are some good options, love! We are fortunate that you have such allies and are such a strong and brave adventurer to carry the favor of a goddess! Even acquiring the personal service of a great alchemist is a feat in of itself!</i>\" she says, before grabbing you and hugging you against her chest. \"<i>I am so happy that you stumbled across my tower! You have given me hope that I will one day have a bright future,</i>\" she says before pecking you gently on the cheek.");

				outputText("\n\nYou spend a bit more time with the grateful siren by the pure spring, before reluctantly departing, after all you have much work to do, you have to talk to Marae and Rathazul about healing Minerva.");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
				flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 0;
				flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 1;
			}
			//Jojo Follower & Rathazul
			else if (!checkMarae() && checkJojo() && checkRathazul()) {
				outputText("\n\nBetween Jojo's spiritual knowledge and Rathazul's alchemical knowledge, you're quite confident they can produce something that will help Minerva. Excitedly, you tell Minerva about a few options you have for curing her. Hearing that you have a few different ideas brings a smile to her face, clearly happy to hear such promising news.");

				outputText("\n\nImmediately, you start to tell her about Jojo and Rathazul, going on to explain how you met both, the Alchemical master and the mouse monk. At hearing some of your adventures Minerva seems more excited; the possibilities of both a spiritual monk that has helped you curb your own corruption and an experienced alchemist seem like good options to go with. \"<i>It's fantastic, my love, that you have such allies at your side to help you! I wish I could have been so fortunate when I came to this world.</i>\" she says, before hugging you tightly into her bosom. \"<i>I am so happy that you stumbled across my tower, you have given me hope that I will one day have a bright future.\" she says before pecking you gently on the cheek.</i>\"");

				outputText("\n\nYou spend a bit more time with the grateful siren by the pure spring, before reluctantly departing, after all you have much work to do, you have to talk to Jojo and Rathazul about healing Minerva. ");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
				flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 0;
				flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 1;
			}
			
			//All three. (A WINNER IS YOU)
			else if (checkMarae() && checkJojo() && checkRathazul()) {
				outputText("\n\nYou can think of three people who might be able to help. Jojo's spiritual powers seem like the best bet to help Minerva, but if he can't you can always go to the source; even in her weakened condition, with the factory shut down, surely Marae's powers can heal one siren? And if Marae's too weak she may be able to give you something that Rathazul and Jojo, working together, can use to create something that will work. Excitedly you tell Minerva about a few options you have for curing her. Hearing that you have a few different ideas brings a smile to her face, clearly happy to hear such promising news.");

				outputText("\n\nImmediately, you start to tell her about Marae, Jojo and Rathazul, going on to explain how you met a deeply spiritual monk, Jojo, the Alchemical master, Rathazul, and Marae, the goddess of Mareth herself. At hearing some of your adventures Minerva seems ever more excited, hope glimmering in her eyes as you tell her about all the options you could take to cure her. With all these choices at least one of them has to work, right? \"<i>Oh, darling! This is wonderful news! You're so amazing, you know that? Garnering the favor of a goddess, finding such delightful companions in a monk and alchemist...</i>\" She trails off with a bright-yet-dangerous sharky grin as she gently pokes you in the side.");

				outputText("\n\nFor some time the two of you discuss who to approach first and, though Minerva suggests trying Marae first, it is ultimately up to you to talk to them and choose what you believe would be your best course of action. The redheaded siren hugs you tightly into her bosom. \"<i>I am so happy that you stumbled across my tower! You have given me hope that I will one day have a bright future. Even if none of these work, as long as I have you, I think I would be alright,</i>\" she says, before pecking you gently on the cheek.");

				outputText("\n\nYou spend a bit more time with the grateful siren by the pure spring before reluctantly departing, after all you have much work to do, you have to see to Marae, Jojo and Rathazul about healing Minerva. ");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 2;
				flags[kFLAGS.MINERVA_PURIFICATION_MARAE_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_JOJO_TALKED] = 1;
				flags[kFLAGS.MINERVA_PURIFICATION_RATHAZUL_TALKED] = 1;
			}
			
			//No pures? Off you go!
			else {
				outputText("\n\nYou ask Minerva if she has any ideas about who might be able to help you, any clue at all.");
				
				outputText("\n\nThe shark-harpy furrows her brow in thought and tentatively rubs at her bottom lip. \"<i>Best bet I can think of is to seek out someone with spiritual powers; a god or a holy man or someone like that. An alchemist might also be able to at least come up with some kind of bug poison for the parasite inside me... but I don't know if any of those are left anywhere in this world.</i>\" She half-flaps her wings and holds her hands out, a gesture signaling her helplessness. \"<i>I'm sorry I can't be of more help. If there is anything you can do or think of, I'll do everything I can to help,</i>\" the siren says, before brushing a hand against her hair. \"<i>This is my dream, you know; if you were able to help... I would be eternally grateful</i>\"");
				
				outputText("\n\nYou put a hand on her shoulder in an attempt to comfort her, telling her that you will search high and low for a solution and be back as soon as you can with help for your siren companion. Your words seem to affect her and bring a small smile to her face. \"<i>Thank you, love, I am so happy that you stumbled across my tower! You have given me hope that I will one day have a bright future. Even if none of these work, as long as I have you, I think I would be alright,</i>\" she says, before pecking you gently on the cheek.");
				
				outputText("\n\nYou spend a bit more time with the grateful siren by the pure spring, before reluctantly departing. After all you have much work to do, as you have to find a way of healing Minerva.");
				flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 1;
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		
		//Minerva Gets Purified By Marae
		public function purificationByMarae():void {
			clearOutput();
			outputText("You return to Minerva's lair with great excitement, clutching the precious seed close against your heart. You call out to your siren lover, eager to share this exciting news with her.")
			
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] == 0) outputText("\n\nHearing your excited calls draws Minerva over from her place of rest near the pure spring, her curiosity clear on her face as she wonders what's making you so excited. \"<i>What is it, lover? What's gotten into you?</i>\" she questions you before her eyes widen and she brings a hand to her lips, biting it softly. \"<i>Did you... could it be that you found a way to purify me and purge my body of this disgusting creature?</i>\"");
			else outputText("\n\nHearing your excited calls draws Minerva's attention from the harpy that is trying to get her attention from the harpies that fight for her touch, the bird woman/women trying all kinds of lewd things to get her to mate with her/them. Hearing your excited cries win over the arousing actions and she moves away from them, running over to you to see just what's going on. \"<i>What is it, lover? What's gotten into you?</i>\" she questions you, before her eyes widen and she brings a hand to her lips, biting it softly. \"<i>Did you... could it be that you found a way to purify me and purge my body of this disgusting creature, along with this strange lust I feel?</i>\"");

			outputText("\n\nYou nod your head in an excited fashion and triumphantly show her the seed, explaining that Marae said to plant it near the spring so that she could 'make contact' with it in some fashion, after which she will be able to help Minerva to be cured. You ask if she knows a good spot to plant it.");

			outputText("\n\nShe looks at you with wide eyes before gazing down at the seed with amazement, clearly wondering if this little seed could really be the key to being freed. After snapping out of her daze, Minerva turns to the spring and looks at it, her eyes darting around as if trying to find the perfect spot. \"<i>I know just where to plant it.</i>\"");

			outputText("\n\nGrabbing your hand excitedly, the siren practically drags you over to the spring, pulling you to the edge and then flying you to a small grassy patch of ground that emerges right in the middle of the pure spring. Without wasting time, Minerva kneels down and digs a hole right in the middle of the grassy patch before looking up at you with hopeful eyes. \"<i>This is the purest, most fertile spot in the oasis. If the tree should go anywhere, it's here,</i>\" she says, before smiling and sliding a hand into yours, holding it gently. \"<i>Thank you, thank you so much for this.</i>\"");

			outputText("\n\nYou smile and give her hand a squeeze. Then, without further ado, you take the seed that Marae gave you, place it in the hole, and cover it with soil. Before you can say anything, though, you are cut off by a rumbling in the ground underfoot. Instinctively, you and Minerva back up until you are standing in the spring as the soil where you just planted the seed begins to bulge and ripple. A new shoot suddenly bursts through the sod, curling up into the light, as the rumbling stops.");
			player.removeKeyItem("Marae's Seed");
			outputText("\n\nMinerva looks at it in bewilderment. \"<i>Is that it?</i>\" she asks. You're not quite sure what happened, either, but you don't get a chance to say so, as the shoot suddenly seems to explode! What happens next is impossible to really describe as years, if not decades or even centuries of growth take place in seconds, the little shoot swelling and growing, stretching out roots and reaching out with branches towards the sky. By the time it stops, you and the siren are staring gobsmacked at a magnificent oak tree, which dominates the spring and benevolently enshrouds it with branches and roots. The tree's trunk seems to ripple, like water, and then a pair of wooden arms reach gently out of it. Before your eyes, Marae herself steps through and out of the oak as if it were doorway, smiling benevolently at the pair of you.");

			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] > 0) {
				outputText("\n\nWhen she sees the state of the spring, she furrows her brow. \"<i>This water has been contaminated... but, fortunately, it has not yet been defiled; an aphrodisiac, nothing more, and easily remedied.</i>\" The roots of the tree seem to quiver and ripple, and then the color starts to fade from the tainted water, until it is pure and pristine once more. Marae smiles contentedly.");
				flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = -1;
			}

			outputText("\n\n\"<i>My children... You have done so well. Through this act, my connection to this place of power is established, and I am restored to something more of my old strength. I beg you, Minerva, step forward, that I might truly express my gratitude.</i>\" the deity says, her voice chiming with delight and joy at what has been done.");

			outputText("\n\nLooking up at the nature goddess before her with amazement and reverence, Minerva seems spellbound by what just transpired but quickly recovers. This is the day she has long awaited. In just a moment or two she will be free of her parasitic curse and once again be pure and uncorrupted. \"<i>This is... I don't... I never thought this day would come, that I would truly be freed of this monster inside me.</i>\" she says, shedding a tear of pure joy at her dream finally coming to fruition. The siren seems so excited, her hands shaking as she shivers with anticipation. Stepping closer to the goddess, Minerva lowers her head and closes her eyes, waiting for the goddess to free her.");

			outputText("\n\nMarae smiles beatifically at the siren and gently reaches out to lay a hand on either side of Minerva's forehead. Closing her eyes and bowing her head, she begins to sing softly to herself, a strange rhythm that makes you think of both, the wind whistling through the trees and rain gently falling upon the grass, of the sun in summer and autumn leaves falling to the grass. Light slowly begins to form, washing across Minerva's face like a personal dawn and sweeping down and across her body, until every inch of the siren is luminescent.");

			outputText("\n\nYou watch, feeling some trepidation, as Minerva's body begins to change - you thought Marae was supposed to purify her, not transform her! Her hips widen and swell to what you can only describe as brood-motherly hips, growing as if in anticipation of birthing many children, her buttocks swelling and perking to form luscious yet firmly squeezable round ass - the butt of a woman born to bear many children.");
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] != 0) outputText(" Her posture shifts slightly, thanks to her newly widened hips, and you think, but aren't sure, that the part of her bulge denoting her hefty pair of testicles grows slightly smaller.");
			else outputText(" Her posture shifts slightly, thanks to her newly widened hips, and you think, but aren't sure, that the part of her bulge denoting her hefty pair of testicles swells till they are the size of cantaloupes.");
			outputText(" Her breasts swell out magnificently, as if to complement her flared hips and be ready the suckle all the young they would invite her to bare, stopping at around a full and swollen G-cup. Finally, a second pair of luminescent wings slowly takes form on her back, stretching out to maybe half the span of her original pair.");

			outputText("\n\nFinally, Marae falters and, with a gasp of effort, removes her hands from Minerva's face, allowing the light to fade away. At first, you believe that it is continuing to linger, but then you realize that Minerva's coloration has changed. What was once blue is now a rich, warm golden color, while gray has brightened to marble-white. Her beautiful fiery-red hair is now tipped with gold, and her feathers have become a brilliant white, also tipped with gold. You watch as she opens her eyes, to little surprise now, her once vividly, electric blue irises are a golden shade of amber, though you are surprised that the sclera is still pure black. You bite your lip, waiting to see how the siren will react to her transformation.");

			outputText("\n\nAs soon as the transformation is over, Minerva lets out a gasp, her chest rising as if she was taking her first breath. At first she looks around, but closes her eyes quickly as if basking in the feeling of her newly uncorrupted body. The golden siren sighs with relief. \"<i>It's gone... I can't feel that squirming demon's presence in my body anymore. Its foul corruption has been purged from my blood.</i>\"");

			outputText("\n\n\"<i>That much I was able to give you.</i>\" Marae assures her, looking somewhat dismayed. \"<i>Unfortunately, I was not able to remove the other essences from your body, and because of the parasite's influence, my removal of it had a strange effect. I am sorry, but you will never be human again. You are something... new... now.</i>\"");

			outputText("\n\n\"<i>Something new?</i>\" Minerva questions curiously, before opening her eyes and looking down at herself. Gasping with surprise she sees the changes to her body, her hands shaking as she slowly touches her new gold and white body. The new curves of her more voluptuous form feel warm and soft under her touch, though she can still feel the taut muscle that lies underneath. Her wings twitch and slowly move as she tests her new, smaller, secondary wings. \"<i>I... I feel...whole. I don't feel the strange sensation of all my different parts anymore. My body no longer feels foreign. It's like, for the first time in ages, this is truly my own body.</i>\" she says with surprising calmness, and soon a smile breaks across her face, hot tears falling from her eyes as she hugs herself. Despite her humanity officially being stripped away, the siren couldn't be happier with the outcome.");

			outputText("\n\nMarae looks relieved to hear that, then visibly sways. \"<i>I am glad I could assist you both... Now, I must return to my island and recover; even with access to this new nexus, my strength has been sorely taxed. I must rest.</i>\" That said, she steps back into the tree and vanishes with nothing but a fluid rippling of the bark and the wood.");

			outputText("\n\nYou look back at Minerva, wondering what you should say, but are suddenly swept into her embrace, her arms locking around you in a bone-crushing hug, your " + player.faceDesc() + " thrust firmly into her enhanced bosom as she cries out in joy. She finally lets you go, only to sweep forward and kiss you passionately. You can feel the wetness of her happy tears on your face as she kisses you. The golden siren is almost starting to cry again but manages to compose herself, just a little. \"<i>Oh lover... I.. I'll never be able to express how grateful I am. Thanks to you, I'm free of that curse, that corruption that once threatened to overtake me. My love, I'm eternally grateful to you, I swear that I will always sing for you and no one else.</i>\" she says with a blush on her hew gold and white cheeks, The intimate notions of her words unquestionable.");

			outputText("\n\nYou smile at her, and tell her that you're simply happy that she's better. You must confess, though, that you're curious what Marae meant by Minerva being something new? Could it be that Minerva is now truly a siren? That she will father or bear more \"shark-harpies\" like herself?");

			outputText("\n\n\"<i>I'm not sure how to explain it, but I feel filled with new purpose... Like this change is the start of something great,</i>\" she says before smiling shyly at you. \"<i>I don't know if it will work, but... I.... I want you to be the " + player.mf("father", "mother") + " of my offspring. You, who saved me from my terrible fate.</i>\" ");

			outputText("\n\nWhen you hear her request you wonder if it would really work. You could be the ");
			if (player.hasCock()) outputText("father");
			if (player.hasCock() && player.hasVagina()) outputText(" and ");
			if (player.hasVagina()) outputText("mother"); 
			outputText(" of a whole new race in this world! How many people anywhere can say that?");
			awardAchievement("Divine Intervention", kACHIEVEMENTS.GENERAL_MINERVA_PURIFICATION, true, true);
			flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 10; //Complete
			flags[kFLAGS.MINERVA_TOWER_TREE] = 1; //Will alter scene.
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			menu()
			addButton(0, "Babymaking", agreeToMakeBaby);
			addButton(1, "Wait a Bit", declineToMakeBaby);
		}
		
		public function purificationByJojoPart1():void {
			clearOutput();
			outputText("You approach the murine monk with Minerva's fate weighing on your mind. As if he can sense your troubled thoughts, Jojo looks at you expectantly. \"<i>What troubles you, my friend?</i>\" he asks.");

			outputText("\n\nYou talk to Jojo about Minerva, describing her condition, her worries, and her willingness to be purified. You ask if he has any idea on how he can possibly help her, and the monk looks thoughtful.");

			outputText("\n\n\"<i>Hmm... From what you described to me of how she has kept her corruption in check thus far, I believe your friend has managed to find a nexus - a kind of wellspring of purity and holy energies. I think... Yes, I'm quite sure that I remember enough of the rituals of my order to perform an exorcism. Come! Take me to this friend of yours, and we shall see what I can do.</i>\" He gives you a benevolent smile and indicates you should start leading him. You thank him for his kindness and indicate he should follow you.");
			doNext(purificationByJojoPart2);
		}
		
		public function purificationByJojoPart2():void {
			clearOutput();
			outputText("The climb up the mountains feels longer and harder than before - maybe because Jojo, despite his admirable dedication, clearly isn't an experienced mountain hiker. Finally, however, you reach the tower and you head inside, calling out for Minerva to come and meet a friend of yours.");

			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] > 0) {
				outputText("\n\nHearing your excited calls draws Minerva's attention " + (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] < 3 ? "from the harpy that is trying to get her attention, the bird woman trying all kinds of lewd things to get Minerva to mate with her" : "from the harpies that fight for her touch, the bird women trying all kinds of lewd things to get Minerva to mate with them") + ". Hearing your excited cries wins over the arousing actions and she moves away from them, having to be a little forceful to keep the naked harpies off her before running over to you to see just what's going on. \"<i>What is it, lover? Who's your friend here?</i>\" she asks as she looks down at the much smaller mouse-morph before kneeling down to greet him. \"<i>Well hello there little mouse, I have never seen someone like you before. Though I can't really leave to go meet new people, the champion here is kind enough to visit and keep me company.</i>\" she says before looking back up at you with a look of curiosity.");
				outputText("\n\n\"<i>Why would you bring him here? I don't think you would just bring a friend of yours here without reason so why....</i>\" Her words stop as her eyes widen, deducing the reason for this monk-like mouse to be with you. \"<i>Did you... could it be that you found a way to purify me and purge my body of this disgusting creature and rid me of this infuriating lust?</i>\"");
			}
			else {
				outputText("\n\nHearing your excited calls draws Minerva over from her place of rest near the pure spring, her curiosity clear on her face as she wonders what who it is they want you to meet \"<i>What is it, lover? Who's your friend here?</i>\" she asks as she looks down at the much smaller mouse-morph before kneeling down to greet him. \"<i>Well, hello there, little mouse. I have never seen someone like you before. Though I can't really leave to go meet new people, the champion here is kind enough to visit and keep me company.</i>\" she says before looking back up at you with a look of curiosity.");
				outputText("\n\n\"<i>Why would you bring him here? I don't think you would just bring a friend of yours here without reason so why....</i>\" her words stop as her eyes widen, deducing the reason for this monk like mouse to be with you. \"<i>Did you... could it be that you found a way to purify me and purge my body of this disgusting creature?</i>\"");
			}
			
			outputText("Jojo nods his head");
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] > 0) outputText(", trying to avoid looking too hard at either the harpy sluts or Minerva's still partially erect and dribbling cock");
			outputText(". \"<i> I believe that I am capable of helping you... At the very least, I will certainly do all in my power to help you. May I please see the nexus - the purifying spring you have been using? </i>\" he asks.");

			outputText("\n\nNodding her head quickly, she grabs Jojo up into her arms and rushed him over to the oasis, before setting him back down on the soft moss that surrounds the purifying waters. \"<i>I understand that you might not be able to do anything for me, but anything you can do to help will be greatly appreciated. I want to be free of this monster and be cleansed of the corruption I feel</i>\"");

			outputText("\n\nJojo nods his head, and then stares at the pool, stepping over to the edge of the water.");

			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] != 0) {
				outputText("\"<i>\n\nIt looks like something has been added to this pool. Something to pollute it; interfere with its power.</i>\" Jojo muses. \"<i>Fortunately, it doesn't seem to be anything too potent; allow me to just...</i>\" He begins to chant, taking up his staff and making ritualistic sweeping motions through the air. This builds to a climax when he dips the end of his staff into the water, still swishing it around even as he chants. As you watch, ripples flow out from his staff, cleansing the unnatural coloration from the water and restoring it to its former purity. He stops and nods his head with satisfaction.");
				flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = -1;
			}

			outputText("\n\n\"<i>Alright now... Miss? If you would please approach me, and kneel in the water?</i>\" he asks Minerva. The shark-harpy in question nods and approaches the water slowly, before gently stepping into the water, turning back around so she is facing you and the mousey monk. The pool may be large but it's not too deep, the pure, clean waters only coming up to her mid thigh due to her very tall stature. \"<i>Just like this? By the way, my name is Minerva and I'm very pleased to meet you.</i>\"");

			outputText("\n\n\"<i>Thank you for sharing your name, Miss Minerva. And yes, that's perfect. Now, I'm not a fully trained acolyte, so I will try to remember how to do this...</i>\" Jojo trails off, closes his eyes, inhales and exhales sharply several times, then begins to chant. His voice is surprisingly low and deep for a mouse-man. You can hear the words, a tongue you can't recognize, rumbling up from inside him and into the air. Reaching as high as he can, he gently touches Minerva on the eyes, then the ears, the nose and then the tongue. He makes several arcane-looking gestures with his hands, and taps her on the forehead (he has to give a little hop to reach that far) and then on her chest, just above her breasts - you think it's supposed to indicate the heart.");

			outputText("\n\nYou wonder what he's doing, and then notice that the water in the pool seems to be glowing, taking on a beautiful moon-white luminescence. The new glow coming from the pool startles Minerva, and she clearly doesn't know what to expect from a ritual like this but whatever it is, it's clearly doing something, as the red haired siren starting to feel a tingling in her body. Still chanting, Jojo reaches down and scoops up a double handful of water. His words reach a crescendo as, with as much gravitas he can muster, he suddenly splashes the water gently on her forehead. The effect of Jojo's actions is instantaneous and violent, Minerva is engulphed in intense pure, clean white flames. The flames burn like nothing you've seen before, with even Jojo scrambling back in horror as they surge upwards in a column of wildfire that shows no trace of the hermaphrodite who was its source. Then, as suddenly as they appeared, they disappear, leaving not the charred ashes floating on the water that you were expecting, but Minerva, completely unharmed!");

			outputText("\n\nThis is not to say that she has not been unaffected. As soon as the flames had exploded onto her body, Minerva had locked up, almost panicking at the sight of them but slowly relaxing as they faded from her body as if they had never even been there. There had been no pain, no burning sensation. Just to make sure, she started checking herself for damage but found that instead of being horrifically burned she was fine, though her body was very different than it was before.");

			outputText("\n\nThe new Minerva's colors have changed, which is the first thing you notice. What was once blue is now a rich, warm golden color, while gray has brightened to marble-white. Her beautiful fiery-red hair is now tipped with gold, and her feathers have become a brilliant snow-white, also tipped with gold. You watch as she opens her eyes - to little surprise now, her vividly electric blue irises are a golden shade of amber, though you are surprised that the sclera are still pure black. It says something about how startling this color change is when it grabs your attention first. Her hips have widened as if in anticipation of birthing many future children, becoming the hips a harpy broodmother would be proud of, her ass swelling into a luscious round peach of taut flesh, while her breasts have grown into whopping G-cup mammaries, as if ready to suckle the many children those hips would invite her to bring into the world. ");
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] != 0) outputText(" You think, but you can't be certain, that her balls may have shrunk, if only a little.");
			else outputText(" Looking at her you can clearly see her balls have swollen up to the size of cantaloupes) Finally, and most startlingly, she has sprouted a second pair of wings, maybe half the size of the original ones, further down her back.");
			outputText(" But the changes don't matter to you. You rush to Minerva and desperately ask if the siren's alright. Minerva's eyes are already darting over her new body, the now golden siren now trying to comprehend what just happened to her. She is pulled from her baffled inspection by your rushing into the water and your question of her health. \"<i>I... I think I'm alright... there was no pain when... whatever just happened, happened, but... look at me... what am I? What happened to me?</i>\" she says slowly, before closing her eyes and gently inspecting her new form with her hands, her twin pairs of wings shifting and stretching out to their length before curling back. \"<i>It's gone... I can't feel that squirming demon's presence in my body anymore. Its foul corruption has been purged from my blood.</i>\"");

			outputText("\n\nJojo looks relieved to hear that. \"<i>That's wonderful news! Though, uh, I must confess I have no understanding as to why your proportions and color have changed so drastically.</i>\" he admits.");

			outputText("\n\nMinerva sighs as she opens her golden eyes and looks down at herself. \"<i>I don't know what happened but I... I feel...whole. I don't feel the strange sensation of all my different parts anymore. My body no longer feels foreign. It's like, for the first time in ages, this is truly my own body.</i>\" she says with surprising calmness, and soon a smile breaks across her face, hot tears falling from her eyes as she hugs herself. \"<i>This change is wonderful! I had long ago given up hope of being able to return to my human form, but now I am pure again, cleansed of that vile corruption. Oh, little mouse! You have done me a great service.</i>\" Minerva cries in happiness, before grabbing Jojo up again and squeezing him into her bountiful marble-white cleavage in a tight but clearly very grateful hug.");

			outputText("\n\nThe mouse monk starts blushing so vibrantly you can see it through the fur on his cheeks. Clearly out of his depth, he manages to mumble, \"<i>The demons are the enemies of all good folk. I was happy that I was able to make some effort to help you.</i>\" He promptly wriggles desperately free of her, making of show of patting himself down and doing his best to not let her see his blushing. \"<i>You have a gentle soul, miss. I am happy to have freed you from corruption's vile grasp.</i>\"");

			outputText("\n\nHe makes a polite bow to the newly purified Siren. \"<i>With my work here done, I must return to... well, I guess it is my home. I do hope that " + player.short + " will show it to you. It was very nice to see your home.</i>\" Having excused himself, he heads out the door and away through the mountains. You know he'll be back at camp before you are.");

			outputText("\n\nAs soon as Jojo is out of sight, Minerva wastes no time in showing you her appreciation, grabbing you and pulling you against her now much more curvy frame and cuddling you against her soft flesh, resting your head on her very soft breasts. \"<i>And you, my love, you have done me an even greater service. Not only did you find someone that would cleanse my body and save me from that squirmy beast inside me, you saved me from my despair as well. Coming here so often, being so kind to me, I can never express just how grateful I am to you. I can only make this most solemn promise to you.</i>\" she says with a gentle smile and blush on her cheeks. \"<i>I swear to you I will only ever sing for you, my great savior, my blessed champion.</i>\" She says, ending her words with a gentle, bird-like coo before leaning down and planting a tender kiss on your lips.");

			outputText("\n\nYou smile and kiss her back tenderly, telling her that you're just happy you were able to help.");
			outputText("\n\nMinerva strokes you gently and holds you against her, the golden siren looking thoughtful. \"<i>I'm not sure how to explain it, but I feel filled with new purpose... like this change is the start of something great.</i>\" she says, before smiling shyly at you. \"<i>I don't know if it will work. but... I.... I want you to be the father/mother of my offspring. You, who saved me from my terrible fate.</i>\" ");

			outputText("\n\nWhen you hear her request you wonder if it would really work. You could be the ");
			if (player.hasCock()) outputText("father");
			if (player.hasCock() && player.hasVagina()) outputText(" and ");
			if (player.hasVagina()) outputText("mother"); 
			outputText(" of a whole new race in this world! How many people anywhere can say that?");
			awardAchievement("Divine Intervention", kACHIEVEMENTS.GENERAL_MINERVA_PURIFICATION, true, true);
			flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 10; //Complete
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			menu();
			addButton(0, "Babymaking", agreeToMakeBaby);
			addButton(1, "Wait a Bit", declineToMakeBaby);
		}
		
		public function purificationByRathazul():void {
			clearOutput();
			outputText("Carefully making sure you haven't broken the precious vial of potion, you hurry into Minerva's lair, where you call out to your siren lover, eager to share this exciting news with her.");
			
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] > 0) outputText("\n\nHearing your excited calls draws Minerva's attention from the harpy that is trying to get her attention from the harpies that fight for her touch, the bird woman/women trying all kinds of lewd things to get her to mate with her/them. Hearing your excited cries wins over the arousing actions and she moves away from them, running over to you to see just what's going on. \"<i>What is it, lover? What's gotten into you?</i>\" She questions you before her eyes widen and she brings a hand to her lips, biting it softly. \"<i>Did you... could it be that you found a way to purify me and purge my body of this disgusting creature, along with this strange lust I feel?</i>\""); 
			else outputText("\n\nHearing your excited calls draws Minerva over from her place of rest near the pure spring, her curiosity clear on her face as she wonders what's making you so excited. \"<i>What is it, lover? What's gotten into you?</i>\" She questions you before her eyes widen and she brings a hand to her lips, biting it softly. \"<i>Did you... could it be that you found a way to purify me and purge my body of this disgusting creature?</i>\"");

			outputText("\n\nYou tell her of Rathazul's potion, and offer it to her. You comment that it seems to be her best chance of being cured, but warn her that it's untested, experimental and unpredictable.");

			outputText("\n\nMinerva gives you a soft, sad smile. ");
			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] > 0) outputText("\"<i>I don't think I have very long before this... thing... inside me finishes what it's supposed to do. It's worth a shot,</i>\""); 
			else outputText("\"<i>It can't possibly be any worse than what I'm already going through, trapped here forever,</i>\""); 
			outputText(" she tells you. She takes your hand that's holding the vial gently in hers, then slowly peels your fingers open and takes the vial from you. She holds it aloft, staring into its contents, then pops it open and drinks it. Maybe halfway through the contents, she stops, choking and gagging. It falls from her nerveless fingers and she topples to her knees, groaning in a pain - filled manner.");

			if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] > 0) {
				outputText(" The vial falls to the ground shatters, spilling the contents in the progress. The liquid flow right into the spring. With each passing second, the water gradually become clearer, as if the effects of potion counter the effect of contaminant."); 
				flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] = -1;
			}
			player.removeKeyItem("Rathazul's Purity Potion");
			outputText("\n\nYou rush to her side, and she grabs your hand desperately. \"<i>It hurts... it hurts!</i>\" She wails, arching her back in pain. You watch in horror as her stomach visibly swells and seems to ripple - her parasite seems to be fighting inside her, battering her belly as if desperate to force its way out. Helpless, you cling to her, trying to offer her your strength. She arches her back in pain and lets out an agonized cry as the horrific sound of snapping bones fills the air.");

			outputText("\n\nHer lower back bulges in the most repugnant fashion, and then, to your shock, wings literally burst from her back, blood splattering across the stone and moss behind her as naked bone stretches out into the air, flesh and sinew and skin and feathers sliding across to cover it, layer by layer, until within seconds she bears a second pair of wings, maybe half the span and size of her original pair.");

			outputText("\n\nThe sounds of cracking bones continues as her hips displace, growing wider and wider until they stop, leaving her with the hips of a broodmother meant to birth many children. Her ass begins to swell and grow, plumping out and tightening into firm, squeezable muscles until it's proportionally big and exaggerated as her hips are. At the same time, her breasts also begin swelling, stopping only after they reach a hefty child-suckling G-cup in size with 1-inch nipples.");

			outputText("\n\nThe ghastly sounds fade away, as do Minerva's own pained sounds, and she slumps into your shoulders, panting and sweating from the ordeal. You can feel her parasite quivering inside her body, thrashing desperately to escape, but rapidly growing weaker. As its final struggles fade and it truly dies, you behold the final change of color. The blue parts of Minerva's skin turn golden, the gray parts turn marble white. Gold streaks the tip of her hair and her feathers, while the bulk of her feathers turn snowy white. She opens eyes, the blue of which is turning rich amber-gold, and meets yours, giving you a faint, relieved smile. You ask her if she's okay.");

			outputText("\n\nShe opens her mouth, as if to say something, then goes cross-eyed. What comes out instead is a burp of such violent force that it almost bowls you over, accompanied by a small cloud of toxic-smelling gas that is, thankfully, rapidly propelled past you and away, to be dissipated by the breezes.");

			outputText("\n\nStoically, you repeat your question to the embarrassed siren. \"<i>Actually... I feel pretty good.</i>\" She confesses. She then stops, blinks her now-amber eyes, and visibly has realization dawn upon her. \"<i>I mean I feel really good! It's gone... I can't feel that squirming demon's presence in my body anymore. Its foul corruption has been purged from my blood. What's more, I... I feel...whole. I don't feel the strange sensation of all my different parts anymore. My body no longer feels foreign; it's like, for the first time in ages, this is truly my own body.</i>\"");

			outputText("\n\nShe stands up again, stretching herself wide, experimentally flapping her wings and hefting her enhanced bosom, groping her ass. \"<i>Hmm... Can't really say I'm that enthused for the size increases, but I'd call them a very worthwhile trade indeed.</i>\" She suddenly gives you a sharkish grin; before you can react, you are suddenly swept into her embrace, her arms locking around you in a bone-crushing hug, your " + player.faceDesc() + " thrust firmly into her enhanced bosom as she cries out in joy. She finally lets you go after a moment, only to sweep forward and kiss you passionately. You can feel the wetness of her happy tears on your face as she kisses you. The golden siren almost starting to cry again but manages to compose herself, just a little. \"<i>Oh lover... I.. I'll never be able to express how grateful I am. Thanks to you, I'm free of that curse, that corruption that once threatened to overtake me. My love, I'm eternally grateful to you, I swear that I will always sing for you and no one else.</i>\" She says with a blush on her hew gold and white cheeks. The intimate notions of her words are unquestionable.");

			outputText("\n\nYou ask if she's sure she feels alright, if everything feels normal now.");

			outputText("\n\nShe nods insistently, then looks a little embarrassed. \"<i>Well... There is one feeling that's kind of weird. I'm not sure how to explain it, but I feel filled with new purpose... Like this change is the start of something great.</i>\" She says before smiling shyly at you. \"<i>I don't know if it will work. but... I.... I want you to be the father/mother of my offspring. You, who saved me from my terrible fate.</i>\" ");

			outputText("\n\nWhen you hear her request you wonder if it would really work. You could be the ");
			if (player.hasCock()) outputText("father");
			if (player.hasCock() && player.hasVagina()) outputText(" and ");
			if (player.hasVagina()) outputText("mother"); 
			outputText(" of a whole new race in this world! How many people anywhere can say that?");
			awardAchievement("Divine Intervention", kACHIEVEMENTS.GENERAL_MINERVA_PURIFICATION, true, true);
			flags[kFLAGS.MINERVA_PURIFICATION_PROGRESS] = 10; //Complete
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			menu();
			addButton(0, "Babymaking", agreeToMakeBaby);
			addButton(1, "Wait a Bit", declineToMakeBaby);
			
		}
		
		//Post-purification
		public function growTreePostPurification():void {
			clearOutput();
			outputText("You tell her that you have a special seed Marae gave you. It'll make an excellent addition to her lair.");
			
			outputText("\n\nShe looks at you with wide eyes before gazing down at the seed with amazement, clearly wondering if this little seed could really be the key to being freed. After snapping out of her daze, Minerva turns to the spring and looks at it, her eyes darting around as if trying to find the perfect spot. \"<i>I know just where to plant it</i>\"");

			outputText("\n\nGrabbing your hand excitedly, the siren practically drags you over to the spring, pulling you to the edge and then flying you to a small grassy patch of ground that emerges right in the middle of the pure spring. Without wasting time, Minerva kneels down and digs a hole right in the middle of the grassy patch before looking up at you with hopeful eyes. \"<i>This is the purest, most fertile spot in the oasis. If the tree should go anywhere, it's here,</i>\" she says, before smiling and sliding a hand into yours, holding it gently. \"<i>Thank you, thank you so much for this.</i>\"");

			outputText("\n\nYou smile and give her hand a squeeze. Then, without further ado, you take the seed that Marae gave you, place it in the hole, and cover it with soil. Before you can say anything, though, you are cut off by a rumbling in the ground underfoot. Instinctively, you and Minerva back up until you are standing in the spring as the soil where you just planted the seed begins to bulge and ripple. A new shoot suddenly bursts through the sod, curling up into the light, as the rumbling stops.");
			player.removeKeyItem("Marae's Seed");
			outputText("\n\nMinerva looks at it in bewilderment. \"<i>Is that it?</i>\" she asks. You're not quite sure what happened, either, but you don't get a chance to say so, as the shoot suddenly seems to explode! What happens next is impossible to really describe as years, if not decades or even centuries of growth take place in seconds, the little shoot swelling and growing, stretching out roots and reaching out with branches towards the sky. By the time it stops, you and the siren are staring gobsmacked at a magnificent oak tree, which dominates the spring and benevolently enshrouds it with branches and roots. The tree's trunk seems to ripple, like water, and then a pair of wooden arms reach gently out of it. Before your eyes, Marae herself steps through and out of the oak as if it were doorway, smiling benevolently at the pair of you.");

			outputText("\n\n\"<i>My children... You have done so well. Through this act, my connection to this place of power is established, and I am restored to something more of my old strength. Thank you,</i>\" the deity says, her voice chiming with delight and joy at what has been done.");

			outputText("\n\nLooking up at the nature goddess before her with amazement and reverence, Minerva seems spellbound by what just transpired but quickly recovers. ");

			outputText("\n\nMarae looks relieved to hear that, then visibly sways. \"<i>Even with access to this new nexus, my strength has been sorely taxed. I must rest.</i>\" That said, she steps back into the tree and vanishes with nothing but a fluid rippling of the bark and the wood.");
			
			outputText("\n\n\"<i>We have a beautiful huge tree now. It'll be the perfect place to sleep under and we have plenty of shade now,</i>\" Minerva says, happily. You smile back at her and let her know that you're going back to your camp.");
			
			flags[kFLAGS.MINERVA_TOWER_TREE] = 1; //Will alter scene.
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function agreeToMakeBaby():void {
			clearOutput();
			//Male PCs
			if (player.gender == 1) {
				outputText("You don't have to think very hard to know your answer. With such a voluptuous woman asking you to be the father of her children you couldn't possibly say no. You slide your arms around her, your hands reaching back and grabbing her round juicy rump and squeezing her, drawing a surprised gasp from Minerva. Her wide brood-motherly hips feel so enticing against yours that your " + player.cockDescript() + " starts to swell. Grinning devilishly you tell her you can't wait to get started siring a new race with her right away, whispering to her that you think she would make a very sexy mom.");
				outputText("\n\nMinerva can't help but grin and giggle before pulling you down onto the soft moss by the spring and welcoming you into your warm embrace.");
				dynStats("lus", 20);
				pureMinervaSexMenu();
				return;
			}
			//Female PCs
			else if (player.gender == 2) {
				if (!player.isPregnant()) {
					outputText("You don't have to think very hard to know your answer. With such a voluptuous and, judging from what she is packing between her legs, potently virile herm asking you to be the mother of her children, you couldn't possibly say no. You slide your arms down and give her bulging package a playful squeeze, only to feel it start to harden right away under your fingers. At your touch Minerva grins and lets out a long coo, before kissing you deeply and pushing you down onto the soft moss covered ground \"<i>I'm so glad you want to start right now.</i>\" she says as she pushes her hips against you, pressing the heavy growing bulge of her erection against your body, letting you know just how happy she is.");
					dynStats("lus", 20);
				}
				else {
					outputText("You don't have to think very hard to know your answer. With such a voluptuous and, judging from what she is packing between her legs, potently virile herm asking you to be the mother of her children, you couldn't possibly say no. You slide your arms down and give her bulging package a playful squeeze only feel it start to harden right away under your fingers. At your touch Minerva grins and lets out a long coo before kissing you deeply. Pulling back after the kiss she smiles at you and touches your belly. \"<i>I'm so glad you're eager, my love, but I'm afraid we must wait until you have birthed your current child, though.... I'd still be more than happy to make love to you.</i>\" she gives you a naughty grin and starts pushing you gently down onto the soft moss that covers the ground. The golden siren presses her hips against you, grinding the heavy growing bulge of her erection against your body, letting you know just how happy she is.");
					dynStats("lus", 10);
				}
				pureMinervaSexMenu();
				return;
			}
			//Hermaphrodite PCs
			else if (player.gender == 3) {
				outputText("Grinning, you playfully ask who is going to be doing the fathering and the mothering. Since you're both herms either of you could do the job");
				if (!player.isPregnant()) {
					outputText("\n\nOr you could do both, since you're both herms and can get each other pregnant. It's a good question despite the joking. Minerva looks at you before pouting in thought. \"<i>Well... you know.... we don't have to choose, we could take turns. you could take me, and I could take you, and we could have our children together, my love,</i>\" she suggests as her finger draws circles around one of your breasts teasingly, before grinning and pulling you down onto the soft moss by the clear waters, enfolding you into her warm soft embrace again. \"<i>I want you to start though. I want you to be the one I willingly give myself to like this. You will be the first one ever I willingly let into my pussy.</i>\"");
				}
				else {
					outputText("\n\n\"<i>Well... it would be kind of hard for me to get you pregnant when you're renting out your womb already, wouldn't it, hun?</i>\" Minerva jokes. \"<i>Though, as soon as it's empty, I would be honored if you let me give you another child.</i>\" she adds before bringing your hand to her tight, toned tummy. \"<i>But, until then... how about you sire a beautiful baby in mine?</i>\" she finishes before pulling you down onto the soft moss that covers the ground and welcoming you into her warm, tender embrace.");
				}
				dynStats("lus", 20);
				pureMinervaSexMenu();
				return;
			}
			//Genderless PCS.
			else { 
				outputText("Unfortunately, you tell her that you don't have any sexual endowments. \"<i>It's a shame that you don't have anything to start a child. Perhaps when you've fixed your gender, you can come back and we can start, love?</i>\" Minerva asks.");
			}
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function declineToMakeBaby():void {
			clearOutput();
			outputText("Looking at the new Minerva makes it hard to say no, but you're afraid you have to decline, at least for now. Your job as a champion is important and you have to focus on your duties, but you promise her that you would be honored to be the father/mother of her young in the future. Your words put a disappointed look on the would-be broodmother's face. Clearly she was hoping you would help her start a family right here and now. When you promise to come back another time and help her she perks back up, though she still doesn't look as happy as she was before. \"<i>I'll hold you to that, my love. As the one who saved me from my fate, I want you to be the one who gives me my children and you better be ready! I want to have lots and lots of babies!</i>\" she says with a grin and, as if to emphasize her point, ");
			if (player.gender == 1) outputText("her warm hand naughtily reaches down and grabs the bulge in your " + player.armorName + ", before gently squeezing");
			else if (player.gender == 2) outputText("her warm hand reaches down and slips into your " + player.armorName + " teasingly, her fingers exploring until they find your womanhood and rub it gently, the golden siren giving you a naughty sharky grin. Clearly she can't wait to start her family with you.");
			else if (player.gender == 3) outputText("her warm hand reaches down to grab the bulge in your " + player.armorName + ", squeezing your maleness teasingly. At the same time she guides your hand between her legs where you can clearly feel her surprisingly hot nethers pressing against your fingers.");
			else outputText("her warm hand reaches down and slips into your " + player.armorName + " only to feel nothing. \"<i>Wait, you don't have anything to help either of us with having a child,</i>\" she says. She adds \"<i>Come back when you've got a gender, okay?</i>\"");
			outputText("\n\nYou gently pull her hand away from your groin and give her a lingering kiss and a farewell before you leave the tower to make your way back to camp.");
			dynStats("lus", 30);
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Visit tower.
		public function visitTowerPostPurification():void {
			//0: Singing
			//1: Bathing
			//2: Relaxing
			//3: Babies (After having 1+ child with Minerva.)
			//4: Pregnancy (If Minerva is pregnant)
			var chooserArray:Array = [];
			chooserArray[chooserArray.length] = 0;
			chooserArray[chooserArray.length] = 1;
			chooserArray[chooserArray.length] = 2;
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) chooserArray[chooserArray.length] = 3;
			if (player.isPregnant() || kGAMECLASS.highMountains.minervaScene.pregnancy.isPregnant) chooserArray[chooserArray.length] = 4;
			//Select a scene!
			var chooser:int = chooserArray[rand(chooserArray.length)];
			clearOutput();
			outputText("Going in search of your siren lover, you scale the mountain, your memory quickly finding the route to her tower and setting you on the path that takes you to her home. ")
			if (chooser == 0) outputText("\n\nAs you walk along the trail you start to hear something. At first it's quiet, like a whisper on the wind, but as you draw closer to Minerva's tower it becomes clear that the sound is singing, a voice like an angelic hymn being sung by a pure and gentle being.");
			if (flags[kFLAGS.MINERVA_TOWER_REPAIRED] <= 0) {
				outputText("\n\nThe very familiar route hasn't changed since Minerva's purification but you could swear that the area has brightened a little, the slightly foreboding air that used to hang around the tower seeming to have dissipated with a parasite infesting her soul. As you reach the large door to the tower, you notice that what was once a crumbling archway now has a door and looks to be in a much-improved state of repair. It seems Minerva has been busy in her tower.");
				outputText("\n\nPushing open the door you look around the interior. It's not just the outside, but the inside as well has changed. The broken bits of stone that once littered the floor are now gone, some of it even looks to have been painstakingly pieced back together, though what now holds it together, who knows? Your siren lover has been very busy; by the way she acts now it's likely she wants her home looking respectable for when she has all the babies she has always hinted at wanting. Grinning and shaking your head you enter the tower, your eyes beholding the sight of the pure oasis and your siren lover.");
				flags[kFLAGS.MINERVA_TOWER_REPAIRED] = 1;
			}
			else outputText("Once again, you arrive at the tower and push open the door and enter the interior.");
			switch(chooser) {
				case 0:
					minervaSinging();
					break;
				case 1:
					minervaBathing();
					break;
				case 2:
					minervaRelaxing();
					break;
				case 3:
					minervaBabiesMeet();
					break;
				case 4:
					minervaPregnancyMeet();
					break;
				default:
					outputText("\n\n<b>This text shouldn't happen.</b>");
			}
			pureMinervaMenu();
		}
		
		private function minervaSinging():void {
			outputText("\n\nThe song seems to echo around you, adding to its bewitching pitch, and seems to draw you in. As you enter the tower you look around and soon you catch the sight of your golden siren.");
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) {
				outputText("The gold and white skinned woman is perched in her favorite tree, the huge oak tree that dominates the pure spring and overshadows all the others around it, while at the same time seeming to stretch out and shield the other trees with its branches. "); 
				if (flags[kFLAGS.MINERVA_CHILDREN] >= 2) {outputText("As you look around you catch sight of " + num2Text(flags[kFLAGS.MINERVA_CHILDREN]) + " sirens ")
					var sceneChooser:int = rand(3) 
					if (sceneChooser == 0) outputText("perched in the tree.");
					else if (sceneChooser == 1) outputText("splashing playfully in the pool.")
					else outputText("curled up against the roots of the tree.");
				}
				outputText("\n\nUpon a high thick branch Minerva sits, her legs dangling over the edge as she relaxes, her eyes closed for now as she sings her heart out. It's a song the likes of which you have never heard before, sounding at once like both a gentle harmony of songbirds and a soulful hymn. The sound entrances you as you approach the spring, your eyes glued to the near naked form of Minerva as she happily sings her heart out, obviously overflowing with joy that she is pure and free from her burden.");

				outputText("\n\nAs her song ends the siren looks down, having sensed your presence. She grins a sharky grin and jumps down, her four wings unfurling as she glides gracefully to the ground, landing barely a foot or two away from you. \"<i>Darling! You came to visit! Were you listening to my song? Did it lead you here?</i>\" Grinning she jumps you, hugging you into her soft, expansive chest. \"<i>My hero, my champion.</i>\" She coos gently as she holds you against her. \"<i>What can Minerva do for her lover; tell me anything you want and I will do it for you.</i>\" She asks sincerely as she smiles down at you gently, her expression full of accepting warmth and tenderness.");
			}
			else {
				outputText("\n\nThe motherly woman is relaxing on the mossy shores around the spring, bracing herself with one arm as her legs curl along the ground, her posture accentuating her broodmotherly hips. The sun shines through a hole in the ceiling, the light playing off her gorgeous voluptuous body. The sound of her singing fills the air even more so now that you're inside, the bewitching melody drawing you in and almost compelling you to approach her.");

				outputText("\n\nThe golden siren's are eyes closed for now as she sings her heart out. It's a song the likes of which you have never heard before, sounding at once like both a gentle harmony of songbirds and a soulful hymn. The sound entrances you as you approach the spring, your eyes glued to the near naked form of Minerva as she happily sings her heart out, obviously overflowing with joy that she is pure and free from her burden.");

				outputText("\n\nAs her song winds down, her golden amber eyes flutter open and look up at you. A gentle smile spreading across her feminine face, Minerva reaches out with a hand to you, asking you to join her on the soft moss and you find that you can't say no. The siren broodmother wraps her arms around you, hugging you against her curvaceous yet tight and toned body. Darling! You came to visit! Were you listening to my song? Did it lead you here?</i>\" Grinning she squeezes you tighter, hugging you into her soft expansive chest. \"<i>My hero, my champion.</i>\" She coos gently as she holds you against you. \"<i>What can Minerva do for her lover; tell me anything you want and I will do it for you.</i>\" She asks sincerely as she smiles down at you gently, her expression full of accepting warmth and tenderness.");

			}
		}
		
		private function minervaBathing():void {
			outputText("\n\nYour siren lover has been very busy; by the way she acts now it's likely she wants her home looking respectable for when she has all the babies she has always hinted at wanting. Snickering you head deeper into the tower where the oasis lies. As you get closer, you hear gentle humming and even quiet singing coming from the pure spring. Upon closer inspection you find Minerva, happily bathing in the pure waters and humming to herself. ");
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) {
				if (flags[kFLAGS.MINERVA_CHILDREN] >= 2) {outputText("As you look around you catch sight of " + num2Text(flags[kFLAGS.MINERVA_CHILDREN]) + " sirens ")
					var sceneChooser:int = rand(3) 
					if (sceneChooser == 0) outputText("perched in the tree.");
					else if (sceneChooser == 1) outputText("splashing playfully in the pool.")
					else outputText("curled up against the roots of the tree.");
				}
			}

			outputText("\n\nLooking her over as she bathes, your eyes dart over her new, very curvy, and very wet from. Her gold and white skin glistening with water that seems to cling to her sharky skin and giving a new level of definition to her toned curvaceous form. Trickles of water flow down from her heaving, heavy-yet round, full, and undoubtedly milk-filled breasts");
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) outputText(" before slipping down and running over her swollen pregnant tummy");
			outputText(". The water slides down her back from her wet red and gold hair, flowing down over the curvature of her broodmotherly hips and round squeezable ass. Your eyes seemed glued to her new body as she washes it, you can't help but feel arousal start to swell in your loins. The sight of her amazing childbearing body silently calling you to, telling you ");
			dynStats("lus", 10);
			if (player.hasCock()) {outputText("what a willing and fertile female she is and that you must do your duty as a seed bearing ");
				if (!player.hasVagina()) outputText("male");
				else outputText("herm"); 
				outputText(" and have her bear your offspring.");
			}
			if (player.hasCock() && player.hasVagina()) outputText(" Also, ");
			if (player.hasVagina()) outputText("what a virile and pleasurable breeder this gorgeous herm is and that she would bring you other worldly pleasures as she impregnates you so thoroughly.");

			outputText("\n\nA golden eye catches yours and an amorous smile spreads across Minerva's face, a sharky grin soon forming as she turns to face you, not even bothering to cover her full bare breasts to you. \"<i>Like what you see? You've been staring at me for a while. Do you think I am so enticing?</i>\" She teases before wading through the water to you. \"<i>I was just cleaning up; perhaps you want to join me for a bath? Maybe take a closer look at this new body of mine you so enjoy?</i>\" She croons with a teasing grin.");
		}
		
		private function minervaRelaxing():void {
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) {
				outputText("\n\nThe purified spring has never looked so lovely, the huge new tree that acts as its centerpiece perfecting the picturesque scene of nature at its most perfect. Walking through the oasis you find the siren broodmother lying at the base of the oak tree. The red-headed near-naked woman seems to be napping in the shade under what seemed to be her new favorite tree, though its prime status to her makes sense; the huge tree was what allowed her to become purified and be reborn as she is now. ");
				if (flags[kFLAGS.MINERVA_CHILDREN] >= 2) {outputText("As you look around you catch sight of " + num2Text(flags[kFLAGS.MINERVA_CHILDREN]) + " sirens ")
					var sceneChooser:int = rand(3) 
					if (sceneChooser == 0) outputText("perched in the tree.");
					else if (sceneChooser == 1) outputText("splashing playfully in the pool.")
					else outputText("curled up against the roots of the tree.");
				}
				outputText("\n\nGrinning, you approach the edge of the pool before slowly stepping in and wading over to the small island at the center of the pool. With devilish intent you creep up on the sleeping siren, her shapely shark tail twitching gently as she naps. You sneak closer and closer until you are right by her and as soon as you can, you grab her tail and pull. Unsurprisingly, and likely your intent, Minerva is jolted awake by the touch and jumps what seems to be feet in the air. Her four wings fluffing up and spreading out in surprise. The broodmother's golden eyes widen as she looks around for what pulled her tail, as soon as she sees you, though, she visibly calms down. Pouting, she punches you gently in the shoulder, a deep blush on her cheeks. \"<i>Hey! why did you do that? Scaring me like that... you're a mean lover, you know that?</i>\"");
			}
			else {
				outputText("\n\nOnce again you gaze upon the purified spring, this garden oasis tucked in the mountains and hidden inside an old tower. Though not much has changed with the spring itself, its primary inhabitant has very much changed. The lovely golden siren can in fact be seen lazing on the soft moss that blankets the ground around the spring. The red-headed hybrid seems to be curled up in a spot where the sun is shining on her, the light making her seem to glow with a angelic luminescence. Though you know she isn't really glowing, the light makes her seem even more beautiful than normal. "); 
				if (flags[kFLAGS.MINERVA_CHILDREN] > 0) {
					outputText("Looking around you see that there " + (flags[kFLAGS.MINERVA_CHILDREN] == 1 ? "is" : "are") + " " + num2Text(flags[kFLAGS.MINERVA_CHILDREN]) + " young sirens ");
					switch(rand(3)) {
						case 0:
							outputText("perched in the fruit trees");
							break;
						case 1:
							outputText("splashing playfully in the pure spring");
							break;
						case 2:
							outputText("curled up around their mother/father and around the fruit trees");
							break;
						default:
							outputText("<b>ERROR! This text should not appear.</b>");
					}
					outputText(".");
				}

				outputText("\n\nWith devilish intent you creep up on the sleeping siren, her shapely shark tail twitching gently as she naps. You sneak closer and closer until you are right by her and as soon as you can you grab her tail and pull. Unsurprisingly, and likely your intent, Minerva is jolted away by the touch and jumped what seemed to be feet in the air. Her four wings fluffing up and spreading out in surprise. The broodmother's golden eyes widen as she looks around for what pulled her tail, as soon as she sees you, though, she visibly calms down. Pouting, she punches you gently in the shoulder, a deep blush on her cheeks. \"<i>Hey! Why did you do that? Scaring me like that... you're a mean lover, you know that?</i>\"");

			}
			outputText("\n\nClearly she is not angry at all, and is in fact happy that you suprised her with a visit. Sitting back, Minerva stretches and yawns, letting out a dove-like coo before turning to you and reaching out, yanking you to her and placing you in her soft lap with her arms around you, her big pillowy tits pressed against your back as she hold you. \"<i>So nice of you to come and see me, my strong brave champion. Now that I'm awake, what shall we do? Want to cuddle? Or perhaps you would like to take a bath with me?</i>\" She grins and nibbles your ear. \"<i>...Or perhaps you want to work on ");
			if (flags[kFLAGS.MINERVA_CHILDREN] <= 0) outputText("having some babies");
			else outputText("making more adorable daughters");
			outputText("?</i>\" she croons, and teasingly licks your cheek.");
		}
		
		private function minervaPregnancyMeet():void {
			outputText("\n\n");
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.isPregnant) { //Minerva is pregnant.
				if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA) { //Pregnant with sirens.
					outputText("Smiling you stroke your swollen pregnant belly as you approach the spring. You know that you're carrying Minerva's babies, the twins inside you a true sign of your bond with the redheaded siren. You don't have to wait long to find your golden lover. Her very tall, very curvy form can be seen relaxing "); 
					if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) outputText("against the huge beautiful oak tree that sits in the center of the spring, the beautiful hermaphrodite gently singing to herself and the tree as she lays against its shaded trunk."); 
					else outputText("against one of her sweet smelling fruit trees that surround the purifying spring. The beautiful hermaphrodite is gently singing to herself as she lies against its shaded trunk.");
					outputText("\n\nAs you approach you notice that she is a little different than normal. The gold and white siren holds her swollen belly gently, cradling it in a very motherly fashion as she sings softly to her unborn daughters. A smile dawns on your face when you see the sight of how gentle and loving the redhead is with your unborn children, the vision reminding you just what a good mother she will be for your daughters. You're drawn from your thoughts as the singing stops finally, Minerva's golden amber eyes opening and looking right at you. The gentle woman smiles at you and raises a hand to beckon to you. \"<i>My love, how wonderful of you to come and see me. Come to me, come and meet your new daughters... They may be in my belly still, but I know they want to meet their daddy.</i>\" the siren says as she holds her hand out, waiting for you to approach.");
					outputText("\n\nHow could you turn down such a tempting offer from such a beautiful pregnant woman like this? ");
					if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) outputText("Stepping into the water you wade over to the huge oak tree and the childbearing broodmother, as you approach you see her face light up, her eyes being drawn to the obvious sign of your own pregnancy.");
					else outputText("Without another thought you stride toward the childbearing broodmother, as you approach you see her face light up, her eyes being drawn to the obvious sign of your own pregnancy.");
					outputText("It's clear she is ecstatic to see you like that, and as soon as you near her she reaches out and grabs you, pull you down to her and putting her hands on your belly. \"<i>Oh, darling! Are you... is that... oh, lover... I can feel them. The little sirens inside you growing, I can tell already they are going to sing beautifully together.</i>\" She grins a sharky grin and takes your hand putting it on her own bulging belly. \"<i>And they will have sisters to play with as well.</i>\" She says blushing before leaning in and planting a kiss on your lips. \"<i>"); 
					if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText("My virile lover, always so good at filling my belly with babies... "); 
					outputText("Giving me these daughters is the greatest gift you could have given me...</i>\" she says softly as she holds you gently, bulge pressed gently against bulge, her hands stroking your stomach as you caress hers.");
					outputText("\n\nThe two of you lay here against the tree cuddling together as a pair of expecting parents"); 
					if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText(", your daughters curled up with you and Minerva; they seem very happy, as if they all know that they are going to be getting more sisters soon"); 
					outputText(". After some time Minerva finally speaks, her golden eyes locking with yours. \"<i>So, my sweet darling, since you're taking time out of your championing to visit me all the way up here, how shall we spend our time together?");
				}
				else { //Not pregnant or pregnant with something else.
					outputText("You can't help wondering if anything has changed since you had been with her last. If her body was any hint at how fertile she now is, it was likely very easy for her to get pregnant. It's not hard to spot her; the golden siren is sitting on the edge of the spring with her feet in the water, gently splashing the water as she softly sings to herself. When you get closer, though, you realize that she is not really singing to herself but to her round pregnant belly. From where you are you can clearly tell she is stroking her pregnancy gently with her hands as she sings softly to her unborn babies.");
					outputText("\n\nThe scene makes you smile with pride when you see how happy she is to have your children growing inside her. You were planning to surprise her, but seeing her like this you can't bring yourself to play a trick on her. Stepping closer to her, you call her name, making her stop singing and turn to face you, smiling. \"<i>Come and sit with me, my love. Come see the wonderful gift you have given me.</i>\" She says, never taking her eyes off of you as you approach and sit down behind her. Pressing yourself against the siren broodmother's deliciously curvy body, you can't keep yourself from sliding your hands around her body to caress her pregnant tummy. Stroking her softly you see her white and gold cheeks blush as she closes her eyes and leans back against you.");
					outputText("\n\nFeeling her and stroking her body, you could swear you feel the little ones inside kick, clearly enjoying the presence of their daddy. Your gentle, loving touches and strokes draw bird-like coos and croons from the scantily clad siren. Her blushing face looks so peaceful, even as she opens her eyes and looks back at you. \"<i>I love you, I never dared to dream that things would end up so perfectly. You saved me and you've given me everything I have ever desired. As long as I live, you will always have a place with me and your daughters, my brave, daring champion. Tell me, my love, tell me your desires and I will fulfill them.</i>\"");
				}
			}
			else { //Minerva is not pregnant.
				if (player.pregnancyType == PregnancyStore.PREGNANCY_MINERVA) { //Pregnant with sirens.
					outputText("Smiling, you stroke your swollen pregnant belly as you approach the spring. You know that you're carrying Minerva's babies inside you, the twins a true sign of your bond with the redheaded siren. You don't have to wait long to find your golden lover. Her very tall, very curvy form can be seen picking a few of the bright round peaches from one of the ever-productive trees. A gentle humming can be heard coming from her as she sways her broodmotherly hips back and forth, picking fruit without a care in the world.");
					outputText("\n\nYour smile turns into a grin and you quietly whisper to your unborn sirens that you're going to play a little trick on their father-mother. Creeping as quietly as you can up to Minerva, you suddenly reach around her and hug her, your hands wrapping around her as you press your pregnant tummy against her back. The sudden contact makes her gasp in surprise and drop the basket of peaches she was holding. The gold and white woman's surprise soon fades and she relaxes against your body. Minerva looks behind herself at you and smiles. \"<i>Well, hello there, darling, I'm so glad you came to visit.</i>\" She grins and turns in your arms, wrapping her arms around you before starting to stroke your pregnant belly. \"<i>And you brought some guests with you,</i>\" She says before gently rubbing your bulging tummy tenderly, the tall siren kneeling down to plant kisses on you. \"<i>My sweet lover and our babies,</i>\" She says dreamily, seemingly able to clearly tell that they are hers.");
					outputText("\n\nThe tender motherly woman nuzzle your stomach gently as she caresses you with her hands; it's clear to you she will be a most loving mother-father for your siren daughters. Smiling brightly and seemingly full of maternal feelings she hugs you tightly before looking at you with a gentle expression \"<i>So, my darling pregnant beauty, did you come just so show off our beautiful babies, or have you come to spend some time with your faithful siren?</i>\"");
				}
				else { //Pregnant with anything else.
					outputText("You stroke your swollen pregnant belly as you approach the spring, wondering how Minerva will react to your pregnancy as it very well may not be hers. You don't have to wait long to find your golden lover. Her very tall, very curvy form can be seen picking a few of the bright round peaches from one of the ever-productive trees. A gentle humming can be heard coming from her as she sways her broodmotherly hips back and forth, picking fruit without a care in the world.");
					outputText("\n\nYour smile turns into a grin as mischief comes to you. Creeping as quietly as you can up to Minerva, you suddenly reach around her and hug her, your hands wrapping around her as you press your pregnant tummy against her back. The sudden contact makes her gasp in surprise and drop the basket of peaches she was holding. The gold and white woman's surprise soon fades and she relaxes against your body. Minerva looks behind herself at you and smiles. \"<i>Well, hello there, darling, I'm so glad you came to visit.</i>\" She grins and turns in your arms, wrapping her arms around you before starting to stroke your pregnant belly. You can't help but notice the jealous pout she has on her face when she touches your pregnant belly. It's easy to tell she wishes it was her baby in you. You're surprised she doesn't chastise you for getting knocked up by someone other than her, chalking the lack of scolding up to her gentle maternal nature and her feelings for you.");
					outputText("\n\nMinerva looks down at your swollen stomach for a moment slowly rubbing it before looking back up at you and hugging you. \"<i>I'm so glad you're here to visit me.</i>\" She tells you before nuzzling your neck softly. \"<i>Next time, make sure I get to have babies with you, alright? I want to us to have lots of beautiful sweet daughters together,</i>\" She says before patting your tummy gently. \"<i>So, my pregnant beauty, did you come just so show off your beautiful babies, or have you come to spend some time with your siren?</i>\"");
				}
			}
		}
		
		private function minervaBabiesMeet():void {
			var temp:int = rand(2);
			switch(temp) {
				case 0: //Flying lessons
					outputText("\n\nEven from here you can tell she is having a fun time with her young siren daughters, the group of young sirens playing together with their mother-father. The siren broodmother is doing what seems to come naturally, seeking to teach them how to use their wings. The comparatively small herms run around and around, flapping their wings hard as they try to take off. You don't have to wait long to see their result as they lift off the ground and start flying around their mother-father; your offspring are natural born flyers!");
					outputText("\n\nUnfortunately for you, they notice you and turn your way, fly-tackling you with a chorus of \"<i>" + playerParentDesc(true) + "!</i>\" Your gold and white skinned daughters plow into you like living missiles, knocking you over and piling onto you. Your errant offspring are unabashed at this impromptu end to their flying, crawling over you, sitting on you and hugging you. Clearly they are very happy to see you and demand to spend time with their other parent.");
					outputText("\n\nMinerva chuckles and sashays over to the pile of sirens. Even from here you can clearly see her wide broodmotherly hips swaying back and forth with her new natural walk. \"<i>They missed you so much; they always say how they want to see you and how they miss you when you aren't here. I should really bring them down to see you at your camp,</i>\" she says as she crouches down and smiles at you. \"<i>Alright girls, come on, let your " + playerParentDesc(false) + " up, you do want to play don't you?</i>\" She asks her rhetorical question, the young sirens all getting up off of you before helping you up. As you thank them and look down at your daughters you can't help but noticed how quickly they grew up. Though they are not even close to Minerva's impressive 8'5, they grew to roughly 4 feet tall very quickly, though it seems to have slowed a great deal. Your young daughters have already started developing the telltale signs of hips and breasts that will firmly take after Minerva's.");
					outputText("\n\nYou pat them gently on their heads before picking one up off the ground and holding the grinning daughter in your arms, her dagger-like shark teeth on full display in her joy at being held like this. Minerva gently strokes a couple of her daughters on the head before approaching you, the smaller sirens following after. Minerva slides her arms around you before kissing you gently on the cheek. \"<i>It's so good to see you, lover, I and our daughters have missed you greatly. Why don't you come and spend some time with us darling?</i>\" She asks as she strokes your cheek.");
					break;
				case 1: //Presents
					outputText("\n\nEven from here you can tell she is having a fun time with her young siren daughters. The group of young sirens are busy playing together with their mother-father, the siren broodmother doing what seems to come naturally. This time, she's picking peaches from the ever-productive fruit bearing trees around the pure spring. the mother-father and daughters all working together to get the best peaches at the top to eat. "); 
					if (flags[kFLAGS.MINERVA_CHILDREN] < 4) outputText("Minerva holds her two daughters up on her shoulders, letting them use her like a ladder."); 
					else outputText("Minerva holds one of her daughters up on her shoulder, letting her use her parent like a ladder. The other daughters all work together, forming a \"<i>human</i>\" ladder of young sirens, each standing on another's shoulders as they pick the tasty sweet fruit from the trees."); 
					outputText("\n\nSmiling at the cute sight you approach the sirens. As you get closer you see the 'tower of sirens falter and drop their peaches, the herms gasping as they reach out, only for you to catch the peaches yourself. Grinning up at them you take a bite of one and watch their surprised faces. As soon as they see you there is a loud chorus of \"<i>" + playerParentDesc(true) + "!</i>\" Your gold and white skinned daughters give up being a ladder and fall onto you, knocking you over and piling onto you. Your errant offspring waste no time crawling over you, sitting on you and hugging you. Clearly they are very happy to see you and demand to spend time with their other parent. All the peaches you caught end up falling on the mossy ground as your daughters pile on top of you.");
					outputText("\n\nAs you 'struggle' with your errant daughters Minerva snickers at your situation as she kneels down next to you, letting the siren off her shoulder to join her sisters. \"<i>Well, isn't this adorable. Your daughters really missed you, as you can see.</i>\" She says before leaning down and kissing you. \"<i>And so did I.</i>\" She whispers into your ears before ushering the girls up and off of you so you can get up. \"<i>Now I do believe you girls had something to give your " + playerParentDesc(true) + ",</i>\" The siren brood mother says, her words causing the young sirens to gasp and scamper off and find the presents they had gathered for you.");
					outputText("\n\nSoon the young herms gather around you, each presenting something to you. Some present to you food they caught themselves, some seem to have drawn a picture for you, one even holds up a particularly polished looking gem for you. Chuckling you rub each of them on their head and tell them what wonderful gifts they made and brought to you. Your eyes catch the sight of Minerva smiling brightly at you; it's clear she is very pleased and happy to see you with all your daughters.");
					outputText("\n\nWanting a little time to be with Minerva you send your daughters off with a little pat on the rump and tell them to go and play in the spring, the young herms cheering and running off to play. you stretch and put your daughters presents into your bag before approaching Minerva and sliding your arms around her, your hands playfully grabbing her wide ample rear, your touch pulling a grin and a playful gentle slap from your siren lover. \"<i>Darling, the young ones are so near by... But, if you wanted some alone time, we could send them to play a little deeper in the tower so we could have some privacy...</i>\" She purrs.");
					player.gems++;
					statScreenRefresh();
					break;
				default:
					outputText("<b>This text should not happen. Please let Kitteh6660 know so he can fix it.</b>");
			}
		}
		
		private function minervaCorruptionMeet():void {
			    outputText("\n\nThe golden siren appears to be tending to her gardens, humming a happy tune all the while, her delightfully round rump swaying back and forth as her tail swishes back and forth enticingly. Grinning you start creeping up behind her with the intent to surprise your pure gentle lover, your arms out, your [player.feet] barely making any sound at all, To your surprise though it seems that you are not sneaky enough to catch Minerva off guard this time. \"<i>Well hello there my love, I knew you would come, before you even made a sound at all.</i>\" she says before turning to you, her usual gentle kind smile across her glossy black lips.");

				outputText("\n\nThe motherly siren striding toward you in her usual fashion, wide child bearing hips swaying back and forth, the soft, silken sarong she now wears moving in time with her strut. Now barely a few feet from you she reaches out and slides her arms around you, wrapping you in a warm tender embrace. \"<i>I've missed you, so much.</i>\" she whispers into your ear, her voice like the gentle coo of a dove. \"<i>I need to talk to you love, it's important...</i>\" Minerva says as she takes your h and and guides you over to the spring, the golden herm seeming serious about what she has to say to you.");

				outputText("\n\n\"<i>I know what you are, about your....corruption... I've known for a long while actually...you don't have to worry though.</i>\" Minerva says as she slides one of her cool hands up to your cheek, cupping it tenderly. \"<i>Despite that, despite your corruption, I will not abandon you my love, after everything you have done for me, I could never leave you. After all you chose to purify me even though you could have done the opposite</i>\" The gentle woman smiling gently to you before leaning in, resting her forehead against your own, her soft golden eyes gazing longingly into your own for a moment before closing the distance and kissing you softly.");

				outputText("\n\n\"<i>No matter what happens my love, no matter how far you fall, no matter what you become, you will always have a home here with me; you will always have someone that loves you. Even if others cast you aside, call you a monster, I will never do such a thing to you.</i>\" Her grip tightens, her arms holding you against her soft pillow-like breasts. \"<i>Because I love you, now and forever [name], I shall sing for you and no one else</i>\" She whispers to you softly, giving you her solemn vow to always be by your side, to always care for you, her words without even the barest hint of uncertainty, how many in this world would make such a promise in the face of someone so tainted by corruption. \"<i>Just... be careful alright, I don't want to lose you.</i>\"");

				outputText("\n\nHer selfless devotion to you warms even your heart, her gentle kindness toward you never once wavering, a symbol of her unbreakable bond with you. Wrapping your arms around her, you embrace your pure siren lover, warmed by the fact that you will always have someone to turn to, even if everyone else should reject your corrupted self.");

				outputText("\n\nLooking at you closely, her playful sharky grin splitting her full glossy black lips, Minerva leans in, planting gentle kisses over your neck before gently nibbling on you. \"<i>You know, we should celebrate our feelings, how about we spend some special quality time together my love?</i>\" she says playfully, pressing her fertile broodmotherly curves against you, letting you feel her growing arousal beneath her clothes. With such an invitation, how could you decline?");
				dynStats("cor", -3);
		}
		
		public function pureMinervaMenu():void {
			menu();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			addButton(0, "Appearance", pureMinervaAppearance);
			addButton(1, "Talk", minervaTalkSelect);
			if (player.lust >= 33) addButton(2, "Sex", pureMinervaSexMenu);
			addButton(3, "Eat", kGAMECLASS.highMountains.minervaScene.eatSomethingYouCunt);
			addButton(4, "Drink", kGAMECLASS.highMountains.minervaScene.getADrinkYouBitch);
			addButton(5, "Spar", kGAMECLASS.highMountains.minervaScene.fightMinerva);
			if (kGAMECLASS.highMountains.minervaScene.minervaRomanced() && model.time.hours >= 20) addButton(6, "Sleep With", sleepWithMinerva);
			//if (flags[kFLAGS.MINERVA_CHILDREN] > 0) addButton(7, "Children", checkUpOnMinervaChildren);
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.isPregnant) addButton(7, "Pregnancy", checkPregnancy);
			if (player.hasKeyItem("Marae's Seed") >= 0) addButton(8, "Plant Seed", growTreePostPurification);
			addButton(14, "Leave", camp.returnToCampUseOneHour);
		}
		
		private function pureMinervaAppearance():void {
			clearOutput();
			outputText(images.showImage("minerva-appearance-pure"), false);
			outputText("Minerva is a purified siren. She stands 8'5\" with golden skin and a pure belly, neck and inner thighs. White stripes adorn her legs, tail and back. Her head is topped with fiery red orange hair that frames her face with well kept bangs and also slide down her back in a pair of long braids. Her eyes are golden amber on pure black sclera. The siren's body is adorned with an expansive array of golden studs and rings, one through an eyebrow, a pair on her lips and even one in her nose. From her ears hangs large hoop earrings while a trio of studs sits higher up. Along the fin that tips her tail are a set of five gold rings linked together by a fine silver chain.");
			outputText("\n\nAttention-grabbing large golden and white feathered wings sprout from her back; the same feathers flow down her arms like those of a harpy. Two G-cup sized breasts rests on her chest, they would look large on a human, but on Minerva, they appear quite average. Each breast is topped with a firm gold stud pierced nipple about an inch thick.");
			outputText("\n\nHer feather-covered arms would be more at home on a harpy, but contrasts well with her well toned body. Her skin is golden and white and, though she is clothed, you can tell from how sheer her tight tube top is, that her nipples are a tender pink.");
			outputText("\n\nMinerva's wide hips make her waist appear thin and waspish; they sway in unison with a striped shark tail, each step accentuating her hips and tight shorts her rear. A long, pink horizontal scar mars the clean white skin across her stomach and a golden piercing adorns her navel.");
			outputText("\n\nBetween Minerva's lightly toned legs rests all of her sexual organs; a normal vagina, and an unusually thick, sixteen-inch long anemone-like penis. The glans of that yellow and white shaft is ringed by small aphrodisiac-filled tentacles, while the base is surrounded by long tentacles as thick as fingers. Nestled against her soft thighs is a scrotum with cantaloupe-sized balls. She has a tight asshole, placed between her shapely buttcheeks, where it belongs.");
			outputText("\n\nMinerva has large demonic feet, each toe double-jointed and tipped with a large, black talon. Similar to her feet, her tongue also has a demonic quality, being two foot long and fully prehensile.");
			outputText("\n\nA white tube top and a pair of short shorts are all the siren wears for clothing.");
			menu();
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.isPregnant) {
				outputText("\n\n");
				if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation >= 216) outputText("<b>Her belly appears to be a bit swollen.</b>");
				else if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation >= 144 && kGAMECLASS.highMountains.minervaScene.pregnancy.incubation < 216) outputText("<b>Her belly shows obvious signs of pregnancy.</b>");
				else if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation >= 72 && kGAMECLASS.highMountains.minervaScene.pregnancy.incubation < 144) outputText("<b>Her gravid belly has gotten bigger.</b>");
				else if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation < 72) outputText("<b>It's impossible to not notice her pregnancy. She is about to give birth soon.</b>");
			}
			doNext(pureMinervaMenu);	
		}
		
		//------------------
		//  TALKIE TALKIE
		//------------------
		private function minervaTalkSelect():void {
			var talkChooser:int = rand(5);
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) talkChooser = rand(6);
			if (talkChooser == 0) {
				talkingToMinervaAboutBackstory();
				return;
			}
			else if (talkChooser == 1) {
				talkToMinervaAboutSpring();
				return;
			}
			else if (talkChooser == 2) {
				talkToMinervaAboutSharkgirl();
				return;
			}
			else if (talkChooser == 3) {
				talkToMinervaAboutMotherhood();
				return;
			}
			else if (talkChooser == 4) {
				kGAMECLASS.highMountains.minervaScene.bathTimeTalkWithMinerva();
				return;
			}
			else if (talkChooser == 5) {
				talkToMinervaAboutTree();
				return;
			}
		}
		
		//Some placeholder
		private function talkingToMinervaAboutBackstory():void {
			clearOutput();
			
			outputText(images.showImage("minerva-talk-backstory-pure"), false);
			//PART 1 - DONE
			if (flags[kFLAGS.MINERVA_BACKSTORY] == 0) {
				flags[kFLAGS.MINERVA_BACKSTORY] = 1;
				outputText("Informing Minerva that you want to sit down and talk with her seems to surprise her but a gentle smile quickly dawns on her face and she leads you over to a soft patch of moss. \"<i>Really, you want to talk to me? I thought we knew each other pretty well but if you wanted to talk I'd be happy to talk to you. What would you like to know, my love?</i>\" Sitting across from her you ask about her past; how did some come to find be like she is and find this place.");
				outputText("\n\nUpon asking about Minerva's past she looks at you curiously. \"<i>That kind of stuff... there aren't a lot of good memories in there. Those were some hard times, but... I'm glad I went through them. If I hadn't then I wouldn't have met you, and I wouldn't be what I am today.</i>\" The siren proclaims with a gentle smile before looking at you again and blowing you a kiss. \"<i>Well... I guess I should start at how I got here. I guess I'm like you, someone from the other side of one of those portals. I suppose I was a sacrifice of some kind since there was an ambush waiting for me on the other side. It was very close, but I managed to get away, but not without getting hurt.</i>\" She notes, gesturing to the familiar scar on her stomach. Thinking of that scar and how large it is makes you shudder; had that parasite not sealed the wound behind itself, Minerva likely would have died. \"<i>I know that I should have been killed by something like this, but that filthy little creature dug its way into my body.</i>\" You nod in understanding, placing a hand on her shoulder. It all worked out in the end but it was a hard journey to get here.");
				outputText("\n\nWanting to take the topic away from her scar Minerva continued \"<i>Of course they chased me, but they stopped once I reached the edge of the forest and the lake. They seemed to not like the lake and avoided it, giving up on me.</i>\" she says with a look of relief. You know exactly what she is talking about though, going through a very similar, though in retrospect not nearly as harrowing, experience. \"<i>Sometimes I wonder how things would have turned out had the demons not attacked me. Where would I have ended up, if I wasn't in such a hurry to get to safety? ...I probably would have been grabbed up by some beast and used as a sex slave. I think I like this better.</i>\"");
				
				outputText("\n\nThe siren looks to be deep in thought then, perhaps imagining what things would have been like if they were different. After a minute Minerva continues her story. \"<i>Since the demons stayed away from the lake I obviously stayed there for a while, at least a few days, catching fish in the lake to live. Clearly the lake was not safe either; those simple minded anemones and savage shark girls....as you can probably tell I had more than a few encounters with them,</i>\" Minerva looks down at her mostly shark like body. \"<i>I'm suppose to be female, but one of anemones got to me, and, like my own, their penis-tentacles are fairly potent, and it kept stinging once it got a hold of me. I couldn't fight back for long before it started to have sex with me, and I'll admit that at the time I enjoyed it. With all that aphrodisiac in me, I was having the time of my life...</i>\"");

				outputText("\n\n\"<i>I think that's enough for now, my love; I have to tend to things and you need to go about being a big strong champion right?</i>\" She says with a giggle before leaning over and kissing you on the cheek. \"<i>But don't be so busy you can't come and visit."); 
				if (kGAMECLASS.highMountains.minervaScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) {
					outputText(" Our babies need to see their daddy after all.");
				}
				outputText("</i>\" \n\nSaying goodbye to the beautiful golden siren you kiss her goodbye before heading back to camp.")
				// PC returns to camp.
			}
			//PART 2 - DONE
			else if (flags[kFLAGS.MINERVA_BACKSTORY] == 1) {
				flags[kFLAGS.MINERVA_BACKSTORY] = 2;
				outputText("Informing Minerva that you want to sit down and talk with her seems to surprise her but a gentle smile quickly dawns on her face and she leads you over to a soft patch of moss. \"<i>Really, you want to talk to me? I thought we knew each other pretty well but if you wanted to talk I'd be happy to talk to you. What would you like to know, my love?</i>\" Sitting across from her you ask to continue her tale about her past. The shark-harpy purses her lips and smiles softly.\"<i>Well.... I suppose if you want to hear it, I would be alright with telling you the story.</i>\" she says before running a hand through her red hair.");
				outputText("\n\nThe red headed siren began her story again, picking up where she left off. \"<i>Well I think I was at the part with that anemone. That was the start of some bad times in this world but also the start of one of the best times.... so after the incident with the anemone and getting my cock from the the resulting birth I fled from the lake; I didn't want to run into any more of the creatures there so I tried to survive more inland. \"<i> She chuckles and once again looks down at herself. \"<i>It didn't work out too well as you can see. Well... I found this farm and it seemed alright but I didn't want to take any chances, and I was really, really hungry at the time so I just stole some of the peppers that the woman grew there, these bulbous ones, they smelled so good so I scarfed them down like a hungry animal.</i>\" Minerva sighs and squirms a little in her spot, blushing at the memory. \"<i>Silly things, I had no idea at the time they would make me grow balls, and since I ate so many they got really big.</i>\" She seems uncomfortable, but, at the same time, from the look on her face the memory isn't entirely unpleasant.");
				outputText("\n\n\"<i>A-anyway... since the food inland seemed to be a worse option than staying around the lake, I mean I didn't want to turn into some giant-balled freak, though looking at me now. I guess that's just what happened, but I rather like how I ended up. \"<i>She said as she started up and gently squeezed her breasts. \"<i>Don't you think so?</i>\" Minerva asks with a wink before continuing her story. \"<i>So I headed back to the lake, which may have been a mistake but at least eating the fish didn't change me. A few days passed without any incidents until that is I swam into some of the shark-girls that inhabit the lake, they really took a liking to my new male equipment. They were stronger than I was at the time, fast and fierce; they forced themselves onto me. Using me for their pleasure and making me impregnate them with my new male equipment.</i>\" The siren shivers at the memories of sexual violation by the shark-girls, though you're not sure if it was a shiver of disgust or a shiver of pleasure.");
				
				outputText("\n\n\"<i>I guess they really took a liking to me, since they force fed me these soft things that looked like teeth but they changed me. You remember how I used to look, my skin got all grey and blue, I grew a tail like them, I even grew a fin on my back, but that's gone now. Turning me into something like a tiger-shark dicked shark-girl, which actually made things worse for me at the time; there are others in that lake, these more aggressive striped shark-girls with big dicks and balls.</i>\" She bit her lip, momentarily showing her own sharky teeth. \"<i>I sometimes wonder what happened with that tigershark.</i>\" she says with a wistful look before giving you a playful one. \"<i>Don't worry lover, you're a much better mate than she was.</i>\"");
				outputText("\n\n\"<i>Anyway...that tigershark, there was this one that didn't like the fact I was around and had knocked up those sharks, I guess it thought I was trying to wedge in on its harem, and really, really didn't like it. So, it, she decided she was going to add me to her harem, as you can see it didn't turn out like that. I was tired from the other sharks and this one was much more aggressive. She grabbed me and this time I was on the receiving end. The tigershark was so rough. I guess she wanted to teach me a lesson as she raped me as hard as she could before dumping this insane load of sperm into me...so much that my stomach got all big like I was already pregnant...but, you know, I'm pretty sure my balls could churn out more then her any day</i>\" Minerva says proudly, a thick bulge starting to tent her silky sarong thanks to the memories.");
				outputText("\n\n\"<i>Aaahhh... well with it enjoying its orgasm I struggled and managed to get away. In the fight, it dropped one of those 'teeth\ the other sharks had used on me, but this one was glowing. I grabbed the thing and swam and swam until I reached the shore. I ran into the forest and just... I felt like giving up at the time. The world had been trying to kill me or rape me since I got here... it was probably the lowest point in my life. I took that tooth and ate it, getting these lovely stripes of mine.</i>\" The siren smiles and puts a hand to her belly. \"<i>It turns out that I had in fact gotten pregnant from that tigershark and I decided to keep going strong. I didn't have to wait very long, about 12 days after she came in me, I was so swollen with a baby I gave birth. I gave birth to a beautiful adorable baby shark-girl.</i>\" She said with a smile as she strokes her tummy. for the moment reveling in the maternal memories. \"<i>I miss her...</i>\"");
				outputText("\n\nMinerva seemed to smile, though a little sadly at the memory. It was odd, you would think that she would have had very negative feelings about having a shark-girl daughter but clearly she missed her. \"<i>When I saw her... The way she squirmed in my arms and looked at me. All I could feel was a sense of pride and maternal instincts. I kept her, I suckled her, and watched as she grew in my arms. As she drank from me her body swelled to the size of a young girl, maybe 12 years old. It was amazing to watch, and she was so cute, I was happy to have her in my arms...</i>\" Minerva said with a tear in her eye before wiping it away.</i>\" I miss her, my first born daughter. thank you so much for talking with me lover. I'll see you later, alright? Maybe we can finish the story next time.</i>\"");
				
				outputText("\n\nSeeing that she seems to be reminiscing about her lost shark-girl daughter. Shuffling over you give her a kiss before heading back home to your camp, leaving Minerva to her thoughts.");
				// PC returns to camp.
			}
			//PART 3 - DONE
			else {
				flags[kFLAGS.MINERVA_BACKSTORY] = 0;
				outputText("Informing Minerva that you want to sit down and talk with her seems to surprise her but a gentle smile quickly dawns on her face and she leads you over to a soft patch of moss. \"<i>Really, you want to talk to me? I thought we knew each other pretty well but if you wanted to talk I'd be happy to talk to you. What would you like to know, my love?</i>\" Sitting across from her you ask to continue her tale about her past. The shark-harpy purses her lips and smiles softly.\"<i>Well since you're so interested, I would be happy to tell you, I believe we are nearing the end</i>\" she says before running a hand through her red hair.");
				outputText("\n\nThe redheaded siren began her story again picking up where she left off cuddling up against you she smiles and starts her story back up \"<i>I remember where we were, we stopped right after I had my first real daughter,</i>\" already Minerva seems a bit happier though her smile seems bittersweet. \"<i>I miss her so much... my sweet darling daughter, my little girl...</i>\" She sighs and pouted cutely. \"<i> I had no idea at the time that my new instincts would tell me to seek out water, I didn't want to go back to the lake again, but I managed to find a river and ended up giving birth to my daughter there, it wasn't so easy then, didn't have these big curvy hips like I do now. With her just born and so young, I couldn't just travel around. So we stayed at the stream for a while.</i>\" Minerva stopped for a moment, closing her eyes as if she was picturing it in her head, the time spend with her daughter, it brings a bright maternal smile to her face.");
				outputText("\n\nAfter a moment or two of reminiscing Minerva opened her eyes again and sighs happily. \"<i>We stayed there at the stream for months. It was just us, mother and daughter. The stream even had fish in it, plenty of fish to feed just the two of us. It seemed safe for us there and while she was growing up we needed to be by the water. She...grew up fast though. In a matter of months she was about an adult's size. Though she was smaller then me she was the size of the shark-girls and her father.</i>\" You couldn't help but notice the sadness in her voice.");
				outputText("\n\n\"<i>I had no idea that she would grow so quickly; after getting to preteen size I figured that she would just grow normally from that point, but there she was, only a couple of months old and already an adult. It was amazing, but sad, I hoped she would be young for a while longer so I could be her mother more....</i>\" Minerva looks down now looking only a little ashamed. \"<i>She came onto me, she was very aggressive as shark girls are and we...well, we had sex, a lot of it. No doubt I knocked her up too.</i>\" she says before shaking her head. \"<i>A shameful act I know, but at the time I couldn't help myself.</i>\"");
				outputText("\n\nShe was silent for a moment, clearly thinking about what happened with her daughter. \"<i> well after that I knew I had to go, I was having a hard time then; my body was getting more corrupted by the day, I could feel it creeping at the thoughts. It didn't help that I must have ran into a dozen of those green sluts and red little cretins as I traveled, not at the same time of course. Thankfully my new shark-like body was stronger then before, I was able to beat them all down when one of them tried to attack me. I don't know why but I headed for the mountains.</i>\" Minerva said looking up at the broken ceiling of her tower. \"<i>It must have been fate calling me here, so that I could meet you my love.</i>\" she says with a warm smile.");
				outputText("\n\n\"<i>I didn't give up, I couldn't, the corruption a growing and ready threat inside me, at this point it was changing me, it turned my normal human feet into my pretty double jointed clawed feet and my my tongue into this sexy thing here</i>\" Minerva says before opening her tongue and extending what looks to be a two foot long demonic tongue, pulling it back inside she continues. \"<i>thankfully I was growing close to 'help\, so I kept climbing, kept trudging along. It didn't take more than a few days for my food to run out though, and of course it had to happen when I was reaching some of the highest points of the mountains. I could have tried climbing back down but, would probably have passed out from hunger by then and fallen off. Luckily, I didn't have to decide, a trio of harpies found me clinging to the side of the mountain. With me having to hang on it was easy for the natural born flyers to pluck me from the side and fly off, though thanks to my size they had to work together to carry me off to some harpy nest. Like everything else in the world it was easy to tell what they wanted from me. As soon as they dropped me down they were right on top of me again, pulling my clothes off and kissing me with that gold lipstick of theirs, I wonder what it's made of...</i>\" Minerva looked thoughtful for a moment, perhaps trying to figure out what was in the harpy lipstick. \"<i>I wonder if I could milk my tentacles for venom and make my own lipstick from it.</i>\" Seeming to put that idea away for now the golden siren continued.");
				outputText("\n\n\"<i>I have no idea what they put in that stuff but it hit me fast and in record time all I could think of was fucking them. It was like the shark girls all over again but this time I was the aggressor. I'm not sure how long the effects of those kisses lasted, at least a few hours, by the time my head was clear enough to try and make a break for it the three harpies seemed to have had their... fill of me...</i>\" She says, shaking her head at the stupid pun she just made. \"<i>That was awful, anyway, since they were done took the chance to get away. Thankfully those harpies had food, bags full of these big gold colored seeds.</i>\"");
				
				outputText("\n\n\"<i>I was so hungry I didn't care if they changed me. So I dug in, eating the walnut sized seeds one after another until I couldn't eat any more.</i>\" bringing her wings in Minerva gently strokes her feathered limbs. \"<i> I grew these very soon after, sprouting right from my back as my arms got covered in these sleeve-like feathers. It hurt to grow them but it didn't matter to me. I was full of food and had a way to get around quicker. Still sore from the growing I tried my beautiful new wings out, taking off into the air to explore for a way to stem my corruption.</i>\" Her wings fluttered and spread out gracefully, she is clearly proud of her white and gold wings.");
				outputText("\n\n\"<i>I must have flown for hours; the seeds I ate getting burned off fairly quickly, leaving me starving....again... By the way, why is normal food so hard to come by around here?</i>\" she asked seriously, as if it had been on her mind for a while. Shrugging your shoulders you really had no answer for her, though you had been wondering that yourself. \"<i>Well, at least I have my peaches here, they don't transform you. So, after about an hour or two I finally could go no further, exhaustion, hunger and corruption catching up with me I crashed onto a cliffside. I could feel its warm all consuming grasp closing around me, it was so tempting to give in and let it happen. As fate would have it I landed on the rocks just outside this tower, I hadn't seen it while in there air because of the mist,</i>\" smiling gently the siren stroked the soft moss that grows from the ground almost affectionately. You can't help but notice the somewhat bittersweet look on her face but it's only there for a moment, replaced with a happy grin.");
				outputText("\n\n\"<i>I thought that if I was going to become a monster I at least wanted to have some shelter, so I went inside the tower. That's where I found this place. This... oasis of life, hidden away inside the tower. I guess it was built as some kind of sanctuary though it clearly fell into disrepair. This place turned out to be my....salvation... As soon as I saw the fruit on the trees and the fresh water in the spring I couldn't help myself. I feasted, my corruption forgotten I just gorged on the fruit and water, and with each bite, each drink, I felt the corruption recede. My mind and thoughts became more clear, clearer than they had been in a long time. This place is blessed, it didn't get rid of the corruption but it calmed it, made it shrink. I was happy to be more or less back to normal, but...I knew I could never really leave this tower, if I did, the corruption would just come back. This place, while beautiful, was my prison, my gilded cage.</i>\" She says before looking at you. \"<i>I'm glad though, that I went through all that, if I hadn't I would never have met you, and you never would have saved me. Despite the hardships, I wouldn't go back and change anything,</i>\" she says before hugging you gently.");
				outputText("\n\nReaching over you put a hand around her and hug her gently. \"<i>Thank you for listening, to my story, I know it was long and boring,</i>\" she says with a chuckle. \"<i>You're the most important person in my life");
				if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText(". Well... our babies are just as important you understand");
				outputText(",</i>\" she says with a genuine smile. \"<i>You're a wonderful lover you know that, I couldn't be happier that you found me.</i >\" Your loving broodmother says before pulling you down to lay with her on the moss.");

				outputText("\n\nAfter a little cuddling you reluctantly have to pull back from the golden siren and tell her you have to go, that you have much work to do, demons to slay, beautiful maidens to romance. Giving you a playful punch in the shoulder she grins at you and hands you a fresh peach she picked earlier. \"<i>Go on my big strong champion. I know you have much to do, just remember you will always be welcome here, my arms are always open to you.</i>\" She says softly with a light blush on her golden cheeks.");

				outputText("\n\nWith the peach in hand you blow a kiss to Minerva before heading back home to your camp.");
				// PC returns to camp.
				flags[kFLAGS.MINERVA_BACKSTORY_LEARNED] = 1;
				dynStats("cor", -1);
				inventory.takeItem(consumables.PURPEAC, camp.returnToCampUseOneHour);
				return;
			}
			dynStats("cor", -1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function talkToMinervaAboutSpring():void {
			clearOutput();
			outputText(images.showImage("minerva-talk-spring-pure"), false);
			outputText("Informing Minerva that you want to sit down and talk with her seems to surprise her but a gentle smile quickly dawns on her face and she leads you over to a soft patch of moss. \"<i>Really, you want to talk to me? I thought we knew each other pretty well but if you wanted to talk I'd be happy to talk to you. What would you like to know, my love?</i>\" Looking over at the spring, you wonder about it, Minerva has been here for a while so perhaps she knows something about it.");
			outputText("\n\n\"<i>The spring?</i>\" Minerva questions before looking over at the pure waters of the spring. \"<i> Well... truth be told I don't know really anything about it. ");
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) outputText("Marae told me that its some kind of old nexus of pure energies, like a bright lantern glowing in a pitch black room. ");
			else outputText("Jojo told me what he knew about it, He said it's some kind of wellspring of holy power, one of the few untainted places left in this world. ");
			outputText("I do know that it has special properties: that over time it can strip the corruption from something, make soil very fertile and make plants grow quickly, it can even bless a weapon with special properties, like how my own weapon wounds those that are corrupt.</i>\" She says before smiling and tugging on you gently");
			outputText("\n\n\"<i>I'm afraid I that even though I've been purified I still don't know much about it, I do know that and its feels really nice to swim in it!</i>\" she says with a grin before looking back at you. \"<i>Hey, you know, would you want to go for a swim with me? It'll be fun I promise!</i>\" she says with a playful grin before bumping her wide fertile thigh against you to tease you");
			outputText("\n\nThinking about it you decide there would be nothing wrong with going for a dip with the curvaceous golden siren. Getting up from the ground you quickly strip off your " + player.armorName + " and jump into the pool. Seeing how eager you are brings a bring toothy smile to Minerva's slightly angular face, the purified herm jumping up and eagerly stripping as well, freeing her big bountiful breasts, before hopping into the water with a energetic splash.");
			outputText("\n\nThough the water isn't all that deep, only about four feet deep you splash around and swim with the shark-like harpy. Minerva playfully splashing water at you with her tail, laughing as you play and swim, you can't help but look the very curvy siren over, your eyes instinctively falling on her big G-cup breasts, her wide broodmother hips and ass as well as her thick tentacled dick.");
			outputText("\n\nMinerva's womanly body drenched with water, her ample toned features growing much more defined with all the water clinging to her body. Seeing your stares gives Minerva a kinky thrill, grinning she spins in the water and turns away from you, striking a pose for you and pushing her luscious round ass out, the water beading down her naked body as she looks back at you and gives you her usual sharky grin. \"<i>See anything you like darling?</i>\"");
			outputText("\n\nGrinning back at her you reach out to try and grab the teasing siren only for her spin away from your grasp and splash through the waters away from you, her delightfully bountiful butt swaying as she wades through the water. Not one to just let such teasing go you give chase, splashing through the water and sending it all over. Your watery games last for a while, both of you splashing around, playing and flirting until you're both tired and retire to simply laying on the soft mossy bank together. \"<i>This was so fun, I'm so glad you came to visit,</i>\" Minerva says to you before rolling over onto her stomach and resting her head in her hands as she just watches you for a bit. \"<i>You know... I'm feeling a little frisky,</i>\" she says before rolling on top of you and drawing a finger gently across your [chest] slowly, \"<i>how about we have some fun, my love?</i>\"");
			dynStats("cor", -1);
			player.changeFatigue(-10);
			doYesNo(pureMinervaSexMenu, declineSpringSex);
		}
		private function declineSpringSex():void {
			clearOutput();
			outputText("Staying like this for a while the two of you just rest and enjoy each others company, idly talking about a few things before you figure that its time you should go. Putting your " + player.armorName + " back on you gather your things as Minerva watches, pouting that you have to leave so soon. \"<i>Thank you so much for coming to visit. I had a lot of fun, don't be a stranger you hear, come back and visit again soon!</i>\" she says before sitting up and sighing contently.");
			outputText("\n\nSmiling to her you promise to come back and visit soon before heading out and starting the hike back toward your camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function talkToMinervaAboutSharkgirl():void {
			clearOutput();
			outputText(images.showImage("minerva-talk-sharkgirl-pure"), false);
			outputText("Informing Minerva that you want to sit down and talk with her seems to surprise her but a gentle smile quickly dawns on her face and she leads you over to a soft patch of moss. \"<i>Really, you want to talk to me? I thought we knew each other pretty well but if you wanted to talk I'd be happy to talk to you. What would you like to know, my love?</i>\" remembering your past conversations with Minerva you remember her mentioning her mentioning that she had birthed a shark girl daughter at one point in her life, it seemed like a sensitive topic with her though. Really wanting to know more you ask to know more about this daughter of Minerva's");
			outputText("\n\nThe golden siren's eyes widening when she hears you want to talk about her firstborn daughter, biting her lip she decides there is no harm in going into deeper detail about her shark-girl daughter \"<i>Well... alight, I don't see anything wrong with telling you. Ahhh...she was a sweet girl, so lively and playful, I remember the day she was born, the day I first held that little sweetie in my arms. She was much bigger than that anemone creature I birthed, you should have seen her, big red eyes, so bright with wonder as I held her in my arms, red and white hair, little fingers that reached out for her mama. I had never seen such a cute little girl, even though she was a shark-girl, that didn't matter; to me she was just my adorable baby girl.</i>\" Minerva says with a bright smile as she remembers her daughter. Hearing her describe it like this, you can't help but smile at the tender scenes the siren tells you about.");
			
			outputText("\n\n\"<i>I'm sure you've noticed ");
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText("by how our own sweet little daughters grow up");
			outputText(", that things grow up quickly here, and so did she, when I nursed her for the first time she grew up right there in my arms, not stopping until she was about a preteen, maybe a very young teenager. Even then she was just so cute, she would follow me everywhere, the adorable little sweetheart always holding onto my tail so would never lose her mommy hehehe</i>\" Minerva giggles and grins and bright sharky grin at the thought, and you have to admit, it would be an adorable thing to see.");
			
			outputText("\n\n\"<i>The little one would never leave my side, I had never been a mother before then so I did the best I could, I played with her, kept her well fed and taught her all that I could, how to feed herself, how to defend herself and be wary of her surroundings at all times, like a sponge she absorbed it all up. I really wish I could have had more time with her...</i>\" The siren says, sadness bleeding out into her smile, clearly wishing she could see her first born daughter again.");
			outputText("\n\n\"<i>I'm sure I have told you this already, but there was an incident between us. She grew up so fast, became an adult in only a few months really. It was such a shock to me, I had no idea she would grow that quickly, if I had, I would have taught her not to just let her more primal needs get the better of her</i>\" She said looking at the oasis and sighing. \"<i>I guess it could've had something to do with her shark-girl nature as well, the ones I encountered always were aggressively sexual creatures especially when it came to breeding.</i>\" Minerva says with thoughtful look on her face before shaking her head.");
			outputText("\n\n\"<i>It's my own fault for not doing enough, for not being strong enough to resist her and teach her properly at the least I should have been more gentle with her. We had sex... a lot of sweaty, passionate sex. Once she seduced me I just couldn't hold back, she sucked me off, rode me, I plowed her so hard in my lustful haze, I came inside her half a dozen times that night, she made me feel so good for the first time in ages, I couldn't help myself.</i>\" shaking her head Minerva runs a hand through her hair.</i>\"With how needy and fertile those shark-girls are, I know I had to have gotten her pregnant. How crazy is that? That I knocked up my own daughter and have a grandchild that I personally fathered...</i>\" The siren says with some regret in her voice, but it seems like she has made peace with what she did in the past. \"<i>I miss her, I really do. I wish we hadn't parted like that, I wish I could have taken her with me. One day though, I'll see her again, maybe get another chance at being a proper mother for my daughter and granddaughter.</i>\"");
			outputText("\n\nShe says with a final sigh before looking to you and hugging you. \"<i>Thank you listening to me darling; I'm so happy to have someone like you in my life.</i>\" Minerva whispers to you with a genuine smile on her luscious black lips.");
			outputText("\n\nThe two of you stay like this for a while, just spending a little time together before you decide you must return to camp and your quest. Saying your goodbyes you give Minerva a kiss before heading home.");
			dynStats("cor", -1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function talkToMinervaAboutMotherhood():void {
			clearOutput();
			outputText(images.showImage("minerva-talk-motherhood-pure"), false);
			outputText("Telling Minerva that you want to sit down and talk with her seems to surprise her; she certainly didn't expect you to want to just talk with her. After her surprise, she smiled pleasantly. \"<i>Really, you want to talk to me? Alright, well what do you want to know?</i>\" She asks as she sits down cross-legged on the soft pillowy moss across from you. You rack your brain trying to think of what to talk about. Unable to really think about anything important to talk about you lean back and relax, Deciding to that you could talk for once instead of just listen about random things you have seen, creatures you have encountered, things that tried to sexually assault you, knock you up and try and force you to impregnate them.");
			outputText("\n\nHappy to listen to you for a change Minerva leans against the tree with her legs stretched out, her shark tail laying between her legs. As you tell your tale to your siren friend you can't help but notice how she pays complete attention to you, wrapped up in your story. Wish such an attentive audience it would be a shame not to embellish, just a little.");
			if (player.hasCock()) {outputText(" And so you begin weaving a story of how you fought six minotaurs at the same time, each of them twelve feet tall and carrying huge axes. It was a hard fight, most of your clothes were shredded from the fierce battle, your body glistening with sweat as you stood over your fallen beastial foes.");
				outputText("\n\nWith your foes beaten you saved the group of scantily clad damsels, a pair of goblins, a harpy, a shark-girl and even busty cowgirl, each of them eager to thank their hero for saving them from the mean minotaurs that only wanted to rape them with their pitiful little dicks. Your silly brave story drawing giggles and snickers from Minerva, completely absorbed with your fabrication, whether or not she knows you're lying you can't tell, but its clear she is enjoying your story. Bringing your thankful ladies back to your camp for a long night of impassioned loving.");
				outputText("\n\nRolling right into another story, you be begin to tell Minerva about the time you fought three hundred goblins, it was a fierce battle, with them tearing your clothes off and trying to rape you for your seed. They would cry \"<i>We claim this flagpole for the horde</i>\" but you wouldn't let them have it without a fight, raising your spear of impregnation you thrust hard into their ranks, activating your mighty spears life giving magic, and flooding the enemy lines with rich, potent streams of power.");
				outputText("\n\nYour attack was successful, the thick goopy mess defeating the goblin horde at least for now, they always came back each time with greater numbers. ");
			}
			outputText("With your tale over, your audience claps excitedly, the lonely siren very happy to hear such silly stories. \"<i>Oh that was wonderful! You tell such great stories!</i>\" she says happily as her tail sways between her legs. \"<i>It was a lot of fun to listen to even if they were a bit silly.</i>\" She says with a bring smile before looking down and putting a hand on her toned flat tummy. \"<i>Those damsels and those goblins, if the stories were real, I'm sure you gave them plenty of children.</i>\" ");
			if (flags[kFLAGS.MINERVA_CHILDREN] <= 0) outputText("I do wish that one day I could have kids like that, Have a great big loving family to call my own.</i>\" The siren says before sighing wistfully.");
			else outputText("But I no longer envy them now that I have a great big loving family to call my own, thanks to you.</i>\" she says, sweetly.");
			outputText("\n\nShaking your head you grin and shuffle over to Minerva, sitting down with her, you ");
			if (kGAMECLASS.highMountains.minervaScene.minervaRomanced()) outputText("hug her tightly and kiss her cheek, telling her that she will have children one day, that you will make sure of it.");
			else outputText("You place a hand on her shoulder and give her a comforting smile before telling her that she will one day, you're sure of it."); 
			outputText("Hearing your words beings a smile to her black glossy lips \"<i>Thank you so much. That means a lot to me, really, </i>\" she says gently, her hands stroking yours softly before pulling back. \"<i>Well, I guess we have been here for a while. I'm sure you have a great deal of work to do as such a brave champion.</i>\"");
			outputText("\n\nLooking around you see how late it has gotten and swiftly get up, Minerva's right, you have to get back to your great quest! Looking at the siren one last time you tell her that you will be sure to come and visit again later");
			dynStats("cor", -1);
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function talkToMinervaAboutTree():void {
			clearOutput();
			outputText(images.showImage("minerva-talk-tree-pure"), false);
			outputText("Telling Minerva that you want to talk with her brings a bright smile onto her face, Her eyes seem to sparkle as she grabs your hand and starts pulling you over to Marae's oak tree that stands at the center of the spring \"<i>Love! Come here! I have something to show you!</i>\" The redhead says with a grin");
			outputText("\n\nCurious as to her current excitement you step into the pool and wade over to Marae's oak tree and take your place next to Minerva's white and gold form. Looking around the tree curiously before looking at Minerva, inquiring as to why she is so excited. \"<i>Well after the purification I got a tiny bit lonely at one point and started talking to the tree, I wasn't sure if Marae would come out of the tree again so I just started talking. She may not have come out of the tree but Marae did respond to me.</i>\" She said happily even as you look at her skeptically, it could be possible, after all Marae did herself did come out from the tree when she purified Minerva, so it couldn't be too farfetched.");
			outputText("\n\n\"<i>She and I have been chatting a lot, I think she likes having some form of company since she is by herself on that island. Isn't that right Marae?</i>\" Minerva asked as she strokes the side of the tree. You don't have to wait long for an answer as the tree's surface warps and shifts. a face seeming to stretch out from the bark and become the face of Marae.");
			outputText("\n\n\"<i>Indeed we have Minerva. You ");
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText("and your daughters ");
			outputText("have been a source of much desired entertainment on my long vigil.</i>\" The nature goddess admits freely. Her usual serene appearance selling a little brighter then you remember. \"<i>We have talked about a great many things. She even told me her tale of how she came to be here in this world.</i>\" ");
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) {
				outputText("Marae looked to the siren broodmother before speaking again. \"<i>I have noticed your daughters, while pure like your new self, have certain tendencies toward each other, though it could merely be innocent affection.</i>\" Marae says referring to the young sirens tendency to be very close and even kiss each other in a gentle manner.");
				outputText(" \"<i>I'm sure its just innocent sisterly affection Marae.</i>\" Minerva replies with a nod before looking to where her young daughters were. After what happened with her first daughter it obviously wouldn't surprise her if the young sirens have a few strange tendencies.");
			}
			outputText("\n\nIt's good to know that Minerva won't be lonely without you around all the time now that she can talk to Marae ");
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText("as well as tend to her your daughters");
			outputText(". \n\nYou may even be able to come here and talk to Marae sometimes as well. You're brought from your thoughts by the sound of the goddess and Minerva addressing you again. The three of you spend some time conversing, its strange to think that you're talking to the goddess of Mareth like this along with your siren lover. After some time though you must excuse yourself and head back to camp, leaving Minerva and Marae to their own devices.");
			dynStats("cor", -3);
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Sleep with Minerva!
		private function sleepWithMinerva():void {
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			outputText(images.showImage("minerva-sleepwith-pure"), false);
			outputText("You walk over to the siren and give her a hug. You tell her that you want to sleep with her. \"<i>Of course! I'd love to spend the night with you,</i>\" she says. \n\n", true);
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) outputText("Minerva guides you to the most comfortable spot under the huge oak tree. Being under the tree gives you a great sense of shelter. She takes off her tube top, exposing her breasts completely.\n\n", false);
			else outputText("Minerva guides you to the most comfortable spot. She takes off her tube top, exposing her breasts completely.\n\n", false);
			if (player.armorName == "goo armor") outputText("You take your time to get the metal platebody off until you're completely naked save for the goo-girl covering you. ", false)
			else outputText("You take your time to get your " + player.armorName + " off until you're completely naked. ", false)
			outputText("You lay next to Minerva while you rest your head on her soft breasts. ", false)
			if (player.armorName == "goo armor") outputText("Valeria, your goo-girl companion, envelopes you and Minerva, helping to keep you and Minerva warm. ", false)
			outputText("\"<i>Sweet dreams, love,</i>\" she says as you finally close your eyes. ", false)
			doNext(sleepWithMinervaProcess);
		}
		private function sleepWithMinervaII():void {
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			outputText(images.showImage("minerva-sleepwith2-pure"), false);
			outputText("<b>Ten hours pass...</b>\n\n", false);
			outputText("You wake up, feeling refreshed. You thank Minerva for letting you sleep with her and you hug her, making sure to give her a good kiss. \"<i>Ohhhhh,</i>\" she moans and even blushes! You break the kiss. \"<i>Darling, come back anytime, ok?</i>\" she says. \n\n", false)
			if (player.armorName == "goo armor") outputText("Valeria encases you once more and you get suited up ", false)
			else outputText("You get re-dressed in your " + player.armorName + " ", false)
			outputText("and you leave the tower to return to your camp. \n\n", false)
			awardAchievement("Getaway", kACHIEVEMENTS.GENERAL_GETAWAY);
			dynStats("cor", -4);
			sleepWithMinervaHeal();
			doNext(camp.returnToCampUseOneHour);
		}
		private function sleepWithMinervaPostBirthing():void {
			outputText("<b>Three hours pass...</b>\n\n", true)
			outputText("You wake up, feeling refreshed. You take a good look at your newborn sirenic daughters. Already, they have grown quite a bit! They're now four feet tall. You thank Minerva for letting you sleep with her and you hug her. Next, you pick up the sirenic daughters and give them a playful hug.\n\n", false)
			outputText("They look so excited! They yell \"<i>" + player.mf("Daddy!", "Mommy!") +  "</i>\" You finally set them down on the ground and tell Minerva and her daughters that you have to return to your camp.");
			outputText("\"<i>Come back any time, love,</i>\" she says before she kisses you on your cheek. You finlly set your way back to your camp.");
			awardAchievement("Getaway", kACHIEVEMENTS.GENERAL_GETAWAY);
			dynStats("cor", -4);
			sleepWithMinervaHeal();
			doNext(camp.returnToCampUseOneHour);
		}
		private function sleepWithMinervaProcess():void {
			clearOutput();
			kGAMECLASS.timeQ = 10;
			goNext(timeQ, true);
			sleepWithMinervaII();
		}
		private function sleepWithMinervaHeal():void {
			kGAMECLASS.timeQ = 10;
			camp.sleepRecovery(true);
			kGAMECLASS.timeQ = 0;	
		}
		
		//------------------
		//  SEX SCENES!
		//------------------
		private function pureMinervaSexMenu():void {
			menu();
			clearOutput();
			var btnIdx:int = 0;
			outputText("Minerva grins and slides her arms around you. \"<i>Oh darling, you know I'm always ready to have some fun with you.</i>\" Playfully she reaches down and cups your crotch, gently massaging your "); 
			if (player.hasCock()) outputText(player.cockDescript());
			if (player.hasCock() && player.hasVagina()) outputText(" and ");
			if (player.hasVagina()) outputText(player.vaginaDescript()); 
			if (player.gender == 0) outputText("groin");
			outputText(". \"<i>So darling, how do you want it today?</i>\" ");
			if (player.hasVagina()) outputText("\"<i>Want me to stuff that hot little cunt of yours? Or maybe I should prod your delightful rump?</i>\"");
			
			if (player.hasCock() && player.cockThatFits(kGAMECLASS.highMountains.minervaScene.minervaACapacity()) >= 0) addButton(btnIdx++, "FuckHerButt", fuckMinervasAsshole);
			if (player.hasCock() && player.cockThatFits(kGAMECLASS.highMountains.minervaScene.minervaVCapacity()) >= 0)
			{
				addButton(btnIdx++, "FuckCowgirl", minervaCowgirlSex);
				addButton(btnIdx++, "RestrainFuck", fuckMinervaWithHerHandsBehindHerBack);
			}
			addButton(btnIdx++, "TakeHerDick", chooseVagOrAss);
			addButton(btnIdx++, "EatHerOut", goDownOnAHermAndLoveItYouDirtySlutYou);
			if (player.hasCock())
				addButton(btnIdx++, "Get BJ", letMinervaSuckYouOff);
			addButton(14, "Leave", pureMinervaMenu);
		}
		
		//Same as tainted.
		private function fuckMinervasAsshole():void {
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			var x:int = player.cockThatFits(kGAMECLASS.highMountains.minervaScene.minervaACapacity());
			if (x < 0) x = player.smallestCockIndex();
			flags[kFLAGS.TIMES_MINERVA_SEXED]++;
			outputText(images.showImage("minerva-sex-analpitch-pure"), false);
			outputText("You give her a smile and place a hand on Minerva's thigh, gently pushing to indicate she should get down on all fours. The redheaded siren looks at you for a moment before nodding. Slipping her tight, short shorts down her legs and tossing them aside, she gets down onto her hands and knees, as it is obvious what your intentions are. Spreading her knees apart, Minerva lowers her chest and pushes her curvy rump up, presenting herself to you.");
			outputText("\n\nYou smirk and step forward, reaching out to appreciatively squeeze her firm, plump ass, then draw back a hand and give a playful slap to the nearest of her spankable cheeks, the sudden spank drawing a sharp squeak of surprise from the shark-like harpy, looking back at you with a blush on her face, a little embarrassed, but appreciative of the sentiment. Lifting her long, sharky tail out of the way, she sways it from side to side before curling it gently around your back. Pushing her rear back and bumping her ass against your hips, she's giving you a clear sign that she's ready.");
			
			outputText("\n\nUnfortunately for her, you're not yet ready. Wanting to tease the herm a little more, you run a hand between her legs, feeling the slipperiness of her arousal, and her cool, wet sex spreading to your fingers. Your touch sends shivers of pleasure through the waiting siren. \"<i>Mm... teasing me still? So mean... are you going to make me beg for it?</i>\" she asks with a heavy blush on her face, her tone clearly playful. Bringing your hands up, you grab the lovely golden-white cheeks of her ass. If you're going to be fucking her butt, you want to get it good and sensitive. Squeezing and kneading the firm rear, your hands work it like stubborn dough, getting it ready for the next stage. You let go and you raise one of your hands above her golden rump before coming down on it, spanking her hard and drawing out a loud squeak of pain and kinky arousal. You keep spanking the herm over and over, painting hand print after hand print across the firm round cheeks, each naughty hit making Minerva more aroused, more ready for you to take her. \"<i>P-please... I can't take it! I feel like I'm going to burst!</i>\" she howls, almost pleading for you to finally take her.");
			
			outputText("\n\nWell, no sense in keeping a lady waiting, right? You slip down the lower parts of your " + player.armorName + " until your crotch is bare, exposing [eachCock]");
			if (player.hasVagina()) outputText(" and your [vagina]");
			outputText(" to the open air.");
			outputText("\n\nFeeling Minerva's bare ass rubbing against you helps coax your ");
			if (player.cockTotal() > 1) outputText("shafts");
			else outputText("shaft");
			outputText(" to erectness, and you begin to teasingly drag [oneCock] through the crack of her curvy, spankable ass, hesitating to actually penetrate her until you're ready. Your vexation brings a brighter blush to her cheeks, her tail squirming gently against you as she takes the hint. Her hips start pushing back and forth, using her soft rounded rump to massage [eachCock], wanting to get you just as needy as she is.");
			
			outputText("\n\nDeciding that you've finally teased her quite enough, you drag your " + player.cockDescript(x) + " down through the crack of her ass one last time, then align your " + player.cockHead(x) + " with her tight, puckered asshole. You ask her if she's ready for this, if she's ready to have her ass filled by your throbbing cock. She nods her head, looking back at you with her bright, blushing face, her eyes locking onto yours as she spreads her knees a little further apart. \"<i>I... yes, I'm ready, don't be too rough, all right?</i>\"");
			
			outputText("\n\nDrawing your [hips] back and sinking your fingers into her squeezable butt, you begin to push forward into her back passage. It's surprisingly cool, perhaps because of the shark essence in her blood. Her throbbing anal walls are slick enough to let you slip in easily, but grip tightly around your " + player.cockDescript(x) + ". The inner muscles tighten around you and let you feel dozens of tiny, smooth bumps lining the passage inside. Minerva's walls ripple and massage you as you finally bury yourself to the hilt inside her, groaning in pleasure at her tight anal embrace.");

			outputText("\n\nMinerva bites her lip and pushes her hips back as you push in, doing her best to keep her body relaxed until you're all the way inside before clenching her muscles around you rhythmically. The siren slowly starts shifting her hips around, trying to make it feel better for you as you slowly stretch her unused anal passage. \"<i>Nnn... it feels good, so good. I'm... not used to this, so I should be pretty tight for you,</i>\" she playfully says before pushing back and grinding her hips against yours, while squeezing her tight ass muscles around your cock. Between her legs, Minerva's tentacled dick rises to attention, its thick length throbbing with her arousal.");
			
			outputText("\n\nYou draw yourself back, dragging your " + player.cockDescript(x) + " inch by inch through her grinding, squeezing walls, then thrust yourself firmly back inside her. You repeat the process again, and then again, picking up speed as you pull and push. The siren's lyrical moans slowly start to fill the air, her body rocking with your thrusts, pressing and grinding her pierced nipples against the ground as you pound her slick rear. The longest of her cock tentacles manage to reach back and grabs hold of your " + player.cockDescript(x) + ", feverishly stroking you as you thrust into her. The naughty little things sting you hard, oozing their aphrodisiac venom into your " + player.cockDescript(x) + " instinctively. You cry out, shivering as the potent venom immediately streams through your body, setting your blood aboil with lust, and causing you to piston into her ass with ever-increasing speeds. More and more toxin floods you, combining with the incredible sensations of her anal walls gripping and squeezing you to turn you into a mindlessly rutting beast.");
			
			outputText("\n\nYour suddenly increased pace and new brutal thrusts cause the siren to grit her teeth and clench the soft moss in her fingers. A long, throaty groan is pulled from her, clearly enjoying the rough treatment you're giving her. \"<i>Ahh-ahh... I'm sorry, I can't help it. My tendrils have a mind of their own... it feels so good, oh fuck!</i>\" she moans between gasps, her tail tightening around you to keep hold of you.");
			
			outputText("\n\nYou can't take it any more and, with a cry, unleash your seething, frothy seed into the siren's waiting bowels. The intense, rough fucking and the feeling of your sweltering seed flooding her bowels sets her off as well, the siren's orgasm bursting around you. The siren's tight, slick inner walls squeeze around you as her own member blows its load onto the mossy ground. Minerva's fat phallus throbs and pulses hard, her thick cumvein bulging as it spews its copious load, making a slick, thick puddle beneath her.");
			
			//Moderate cum or less: 
			outputText("\n\nYou keep gushing into her until totally spent, her innards swallowing your load without the slightest effort. \"<i>Ahhh... please, let it all out, give me every drop you can muster!</i>\" she groans loudly as her tail squeezes around you, not wanting you to leave her body, her tight anal muscles squeezing you so tightly, trying to suck everything she can from your cock.");
			//High cum: 
			if (player.cumQ() >= 1000) outputText(" Your unnatural orgasm keeps pouring into her guts, flooding her interior with sticky cum. By the time you give out with a gasp of effort, her stomach is visibly bulging, swollen from the amount of cum you have filled her with. \"<i>Ooohhh... fuck... so much... It looks like I have a baby in there,</i>\" Minerva says with a long, drawn out groan, unused to the feeling of having her guts filled up by such hot, thick stuff.");
			//Very High cum:
			if (player.cumQ() >= 5000) outputText(" Your freakish orgasm continues seemingly without end, cascades of jizz pouring into her bowels and through them to her stomach, \"<i>Oh gods... oh gods... S-so much... how are you cumming this much!?</i>\" You keep cumming though, the sheer quantity resulting in a buildup of pressure that sends yet more of your spunk spurting out from her curvy backside. Finally, when you have finished, Minerva's belly is so swollen that she looks like she could give birth any moment, the creamy sperm inside her softly sloshing around. \"<i>Fu... fuck... h-how... s-so much cum...</i>\" Minerva babbles as a trail of white slowly drips from her drooling mouth before she swallows it back, \"<i>I-I think I can taste it. I've never felt so full in my life...</i>\"");
			
			//Low to moderate cum volume: 
			if (player.cumQ() < 1000) outputText("\n\nPanting from the rough ass fucking she just received, Minerva slumps forward and sighs, her tail pulling you down on top of her smooth, sweaty body. \"<i>That... that was good, it felt really good... You know, we could do that again sometime, if you want to,</i>\" she says before slowly moving and pulling her hips away from yours so she can turn to face you, putting her arms around you for some after-sex cuddling, the golden and white and gray siren nuzzling your neck gently before giving you a peck on the neck.");
			//{High to moderate cum volume: 
			else if (player.cumQ() < 5000) outputText("\n\nGroaning from being filled so much, Minerva puts a hand on her now swollen belly and pushes, clearly feeling the thick stuff sloshing around inside, her belly giving a soft gurgle from being so stuffed. Sighing, she props herself up before slowly pulling her hips forward to get you out, then turning and pulling you close for some after-sex cuddling, the sweet golden siren nuzzling your neck before giving you a little peck. Now that you're not plugging her up, your copious load gushes from her stretched rear, oozing down her round ass and pooling under her flared thighs.");
			//Very high cum volume:
			else outputText("\n\nGasping and gurgling softly, Minerva does her best to hold in the veritable pond of jizz you shot into her. Her hands keep running up and down the huge, swollen belly she has now, clearly amazed that she was able to withstand such a ridiculous stuffing. Swallowing again, she slowly pulls away from you, clearly needing to let off the pressure. As soon as your " + player.cockDescript(x) + " is free, like a cork from a overpressured bottle, your belly packing load bursts from her body, soaking your pelvis and her legs in thick, white cream. Sighing in great relief, Minerva turns toward you and pulls you into a gentle after-sex cuddle, her lips brushing against your neck as she gives you a gentle peck.");
			
			outputText("\n\nYou allow Minerva to hold you against her toned body, recovering your strength from the draining sex. Eventually, though, your strength returns and you gently pry yourself free of her, telling her that the sex and her company was wonderful, but that you need to return to camp.");
			
			if (!kGAMECLASS.highMountains.minervaScene.minervaRomanced()) {
				//First time ending:
				if (flags[kFLAGS.TIMES_BUTTFUCKED_MINERVA] == 0) {
					outputText("\n\nMinerva actually seems a little sad that you're leaving. \"<i>I guess you are a busy person. But I'm glad we did this; it was a lot of fun. And... you know... I wouldn't mind if we did this again soon...</i>\" she says with a small, hopeful smile on her face. You promise her that you'll try to come back again soon. Though looking nervous, Minerva approaches you and pulls you into a hug, happy that you at least say that you will return to visit.");
				}
				//Repeated ending:
				else {
					outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren. \"<i>Well, if you have to go... come back soon, though; we can do this again, if you want. I know I've enjoyed our encounters,</i>\" she explains with a genuine smile on her slightly angular face. You promise her that you'll try to come back again soon. Clearly happy with your promise, Minerva pulls you into a hug, giving you a small peck on the neck before sending you on your way.");
				}
			}
			else {
				outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face. \"<i>I hope you'll come back soon, I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart. The gentle herm pulls you into a deep hug before engaging you in a tongue-tangling kiss. Grinning ear to ear, Minerva finally lets you go, albeit reluctantly, allowing you to leave her tower and return to your camp.");
			}
			//PC returns to main camp menu
			flags[kFLAGS.TIMES_BUTTFUCKED_MINERVA]++;
			player.orgasm();
			dynStats("sen", -1);
			if (getGame().inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function minervaCowgirlSex():void {
			clearOutput();
			outputText(images.showImage("minerva-sex-cowgirl-pure"), false);
			outputText("You look the attractive siren down, letting your eyes roam over the salacious, MILFY siren");
			if (player.tallness < 60) outputText(" with some trepidation, given the difference in your sizes,");
			outputText(" before reaching out with a hand to give her big cushioned ass a spank. You pull her close and ask if Minerva would like to have a little fun together, promising to allow her to control the pace, this time. ");
			if (flags[kFLAGS.TIMES_MINERVA_LAPSEXED] <= 0) outputText("Minerva looks unsure, the siren biting her lip and looking a little away from you, a burning blush staining her creamy cheeks. \"<i>Well... We waited so long already, you have done so much for me, saved my life and gave me a real future. Yes, lets do it, it want it, I need this, I need you!</i>\"");
			else outputText("Minerva smiles brightly and reaches around you, grabbing your own [ass] and pulling you against her body. \"<i>Oh how could I ever say no to you my love. Brace yourself darling, I am going to ride you into the ground!</i>\" she proclaims excitedly before giving your crotch a playful squeeze.");
			outputText("\n\nWith an amorous grin, you slowly remove your clothes and put them aside, giving Minerva a chance to see your naked body. Your " + player.cockDescript() + " already starting to stiffen with Minerva's touch, you lay back on the soft mossy ground, patiently waiting for the siren to make the first move. You don't have to wait long, soon Minerva's tight tube top and short shorts and pulled off, her full-yet-perky G-cup melons bouncing free of their fabric prison. Clearly excited by the thrill of actually having regular sex you can see her male endowment quickly growing hard between her legs, the forearm length appendage ready to go despite the fact it won't be the main event.. Looking down at you Minerva approaches you, her ample broodmotherly hips swaying wide with every step. Standing over you she kneels down, crawling over you like some predator, one of her hands stroking your " + player.cockDescript() + " before sliding up to feel your " + player.chestDesc() + ". \"<i>I promise not to get too excited,</i>\" she says before grabbing hold of your maleness and starting to stroke it. bringing her own male organ up against yours, her tentacles encircling your throbbing cock, stinging it with her potent venom to really get you fired up as she teases you. \"<i>This stuff is always floating around in me, that's why I get so damn hard so fast. I hope you like my special venom.</i>\"");
			outputText("\n\nYou groan softly, feeling the venom already coursing through you. Your " + player.cockDescript() + " surges erect, the venom induced lust making you swell larger than normal, ready for her to do with as she pleases, your limbs numb and useless from the lust-inducing toxins coursing through your body. You are completely helpless and at her mercy... And a part of you likes that.");
			outputText("\n\nMinerva seems to like seeing you helpless like his, her tentacled dick seems to just get harder as her tentacles caress your member, though they don't sting any more; instead, they tease you with their slick touch. \"<i>You like that, don't you? You're so hard I can feel your need only growing more and more. You want my tight pussy so badly.</i>\" She says with a grin before rising her body up and aligning your " + player.cockDescript() + " to her surprisingly cool cunt, already her lips are soaked, her slick juices running down your dick as she teases you more. Finally she ends your torment and grins your fat bloated tip to her refreshingly wet entrance before pushing down, letting you penetrate with agonizing slowness, her longer tentacles still stroking and caressing your length as she pulls you into her snatch's vice-like grip. Inside, you can feel smaller tentacles starting to caress and squeeze you, clearly another trait she was gifted with from the shark-girls.");
			
			outputText("\n\nYou moan in delight, shivering from the sensations and the lingering effects of her toxins, and unconsciously start to thrust your hips up, trying to push yourself deeper in. Minerva, however, will have none of that and promptly pushes you back down, using the advantage of her position and strength ");
			if (player.tallness < 72) outputText("and superior size ");
			outputText("to keep you pinned under her. \"<i>Mmmmm... I don't think so, lover; you said I would be in control... besides you should be more used to my venom by now. You're at my mercy, and I'm going to take my time at pleasing the both of us.</i>\" She says as her groin and vaginal tentacles caress and tease you. She starts slowly pushing her temperate cuny down, the hundreds of little cilia squirming around your shaft as her tight sharky inner muscles squeeze down on you like cool silky vice. Her inner cilia only helping to tease and pleasure your lust fueled cock even more as the surprisingly dominant siren slowly eases herself down down onto your swollen venom - bloated cock.");
			
			outputText("\n\nYou moan and shudder, shivering violently as Minerva's poisons boil through your blood and countless tendrils stoke your lust to a fever pitch. Your brain seethes and roils with pleasure as you are surrounded, engulfed; you don't think you can hold back from cumming for very long, and gasp a warning to the siren that you will cum inside her if she isn't careful. Clearly hearing your response a sinister grin flows onto Minerva's face as two of her longest and strongest tentacles wrap around the base of your " + player.cockDescript() + " and squeeze tightly. Oh no you don't; I'm not even close and you're going to cum? Sorry love, but I can't let that go.</i>\" she says with a smirk. \"<i>Don't worry lover, I'll make it feel so good before I let you pop!</i>\"");
			outputText("\n\nYou beg and plead for her to show mercy on you; you can't bear this much longer! Unfortunately for you the only response you get from Minerva is a smirk and the tentacles tightening around your throbbing maleness as she draws you in deeper. The venom and the aggressive treatment swelling your dick up and stretching her tight squirming walls around you, the stretching drawing a sharp gasp and soft moan from your siren lover. The Sirens heavy balls now coming to a rest on just above your dick, the heavy swollen orbs a reminder that she is enjoying this just as much as you Biting her lip she pushes down harder, sinking her soothingly cool coon down until your whole cock is engulfed in her constricting tight cilia filled snatch. \"<i>Mmm oh yesss... don't you love how your venom filled cock stretches me, all those little things in there stroking you like hundreds of little tongues. Tell me how much you need to cum, tell me and I'll let you blow your pent up load deep inside me. Do it lover, I want to feel your sperm stuffing my womb and finding my eggs, I want your babies so much, darling.");
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) outputText("I want to feel you fill me up so bad, Show our little daughters how much you love their mommy!");
			outputText("</i>\" \n\nYou plead with her, begging her to let you cum; you NEED to cum, you feel like your ");
			if (player.balls > 0) outputText("balls are ");
			else outputText("cock is ");
			outputText("going to burst! You ache for relief; \"<i>Please, let me release myself into your womb</i>\", that is what you cry for her to allow. Licking her lips in anticipation Minerva lets go of your dick, her cum blocking tentacles relaxing around you and letting the pressure off of your swollen prick. With a hollow groan of release you unleash everything you have into her, flooding her waiting womb with your spooge.");
			outputText("\n\nThe idle thought that Minerva may have bitten off more than she can chew by holding back your orgasm races across your brain, scattered like dust on the wind by the thundering bliss of release... Minerva's belly explosively inflates as gout after frothy gout of copious spunk floods her womb, making it balloon out until it is lying heavy and full on your own belly. Minerva's eyes widen as her belly swells up more and more, her trim, firm stomach soon feeling like she was carrying a whole litter of baby shark girls in her. Her hands gently stroking her huge tight belly, the massive load gently sloshing around in her womb \"<i>Ooooh lover... so much, so virile and strong. I'm going to have so many baby sirens after this. So wonderful.");
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) outputText(" You really are trying to get me pregnant all over again aren't you? My little babies are all swimming in their daddy's sperm; how very naughty!");
			outputText("</i>\" \n\nHeaving gasps of breath, you ask her what she has in mind. \"<i>Mmmm well I don't want you getting tired so I'm going to go first....</i>\" She says with a grin as she runs her hands up your " + player.chestDesc() + ". The siren says before her tentacles slither over your balls and the base of your dick, little pricks can be felt as they sting you over and over like an overzealous jellyfish. More and more aphrodisiac venom being pumped into your genitals in such mind numbing quantities.");
			if (player.hasVagina()) outputText(" A few even slither down into your " + player.vaginaDescript() + " to sting you there as well and make sure you are turned, at least temporarily, into a sex hungry beast.");
			outputText("\n\n You gasp and writhe, casting a desperately pleading look at your lover to end your torment and let you be released at last. With that predatory look in her eyes again Minerva clenches her squeezing cunt muscles again around you, biting her lip and as she squeezes as hard as she can on you. Holding you down she starts to pull her widely flared broodmother hips and ample, spankable rump up and down , her round butt bouncing up and down as she grips your dick tightly, her squirming cilia teasing you even as you're ridden by the lusty dominant herm.");
			outputText("\n\nYou don't know if Minerva could have safely held the entire contents of both this orgasm and the last; luckily, this time she allows most of it to just splash back down onto you, but even so her belly swells out rounder and fuller than before, reaching the bloatation of your last orgasm and then some. \"<i>Oh gods... I'm so full... I feel like I'm going to burst... you know you're going to have daughters/more daughters after this don't you?</i>\" She says with a little strain in her voice as she rubs her overly filled body.</i>\" ");
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) outputText("\n\n\"<i>I don't think I'll ever get used to this... my babies, our daughters are swimming in spunk... What a naughty father, giving your daughters such a bath.</i>\" she says with a surprisingly playful look.</i>\"");
			outputText("\n\nWith a fatigued groan and a very satisfied sigh Minerva strokes her cum-bloated belly with a strong maternal affection, licking her lips she smiles down at you. \"<i>So much virile sperm. Such wonderfully potent and productive lover I have. You're going to bless me with so many babies, I know it.</i>\" she says before slowly leaning down, the pressure of her belly forcing out a good deal of your thick frothy splooge from her body. Minerva curls her curvy motherly form around yours, her legs sliding under yours as her arms wrap around you to cuddle you. \"<i>You were wonderful my love.</i>\" She says warmly before kissing your cheek and giving your imbedded dick a squeeze. The golden siren clearly had enjoyed your time together and wanted some after sex cuddling. ");
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.type == PregnancyStore.PREGNANCY_PLAYER) outputText("Her massive childbearing tummy pressing against your body gently as you snuggle.");
			outputText("\n\nYou allow Minerva to hold you against her warm, voluptuous body, recovering your strength from the very draining sex you just had. Eventually, though, your strength returns and you gently pry yourself free of her, telling her that the sex and her company was wonderful and despite still being very aroused due to all the venom she stung you with, you need to return to camp.");
			outputText("\n\nMinerva lets out a disappointed sigh. \"<i>I know, you have an important job to do. I'll miss you though, please come back to visit soon. ");
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText("I know the girls would love to see you again. ");
			outputText("You can be sure that I'll be eagerly looking forward to your next visit my love.</i>\" You give her a last-minute hug, promising that you'll be back as soon as time permits.");
			player.orgasm();
			kGAMECLASS.highMountains.minervaScene.tryToImpregnateMinerva();
			dynStats("lus", 20);
			doNext(camp.returnToCampUseOneHour);			
		}
		
		private function fuckMinervaWithHerHandsBehindHerBack():void {
			var x:int = player.cockThatFits(kGAMECLASS.highMountains.minervaScene.minervaVCapacity());
			if (x < 0) x = player.smallestCockIndex();
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			flags[kFLAGS.TIMES_MINERVA_SEXED]++;
			outputText(images.showImage("minerva-sex-restrain-pure"), false);
			outputText("Looking the lean, toned herm up and down, your eyes trail over her every curve as you think over your options, figuring out what kind of sexual adventure you'd like to go on with the redheaded siren. Your eyes undressing what little clothes she has on as you visually molest the sharky herm. Your intense gaze is drawing a blush from the herm, her eyes looking away shyly. \"<i>Hey... you know how it makes me feel when you look at me like that... but I am glad you like how I look,</i>\" the bashful herm admits before grinning, thrusting her hip out, posing for you and showing off her body.");
			
			outputText("\n\nWith her posing like this, it's easy to get a good look at the teasing siren. Wanting to get a closer look, you start to walk around her, your eyes running over every inch of her, inspecting her form. Finally, your eyes come to a rest on Minerva's full, perky rump and the tight pink pussy that rests between her legs. Licking your lips, you approach her from behind, your hands grabbing handfuls of her tight, short-clad rump and squeeze, drawing a sharp gasp and small jump from Minerva before she looks back at you with a blush. \"<i>Getting a bit grabby, are we? Well, guess someone knows what they want,</i>\" she says with a grin before pushing her butt back at you and grinding it against your hands.");
			
			outputText("\n\nReaching back, the siren slips an arm around you and leans back, smiling to you. \"<i>So, how about you show me just what you want?</i>\" she asks, letting out a throaty coo as if to entice you. With such an invitation, how could you not? You know just what to do with her. Leaning closer, you whisper to her, telling her to trust you just before smirking and pushing her forward. The herm tumbles onto one of the fallen stones that she likes to use as a seat, letting out a squawk of surprise as she falls. The siren thankfully catches herself on the stone, her body now fully bent over the rocks with that tight, round ass sticking up, just asking for your attentions, begging to be played with. Looking back at you, Minerva smiles before grinning and wiggling her hips at you. \"<i>So, you wanted me bent over a barrel for you, huh? Shame I don't have any, but this will do,</i>\" she says with a giggle before flicking her sharktail at you.");
			
			outputText("\n\nWith her so eagerly shaking her hips like that, what could you do but give the siren just what you both want. Grabbing hold of her hips, you reach down, quickly undoing her skin-tight shorts and yanking them down. Tossing the garments aside as you slip a hand between Minerva's toned thighs and feel up her cool, pink pussy. The tight entrance to her body is damp from her strong libido, your soft, teasing touch on such a sensitive part of her is pulling shivers and small croons from her black glossy lips. Your fingers stroke and caress the soft pink folds nestled between her legs, slowly becoming wet with Minerva's growing arousal.");
			
			outputText("\n\nNot yet ready to get down and dirty with the sexy siren, you continue your teasing touches, wanting the herm to beg you to take her. Knowing how sensitive Minerva's round, curvy rear is, you decide to give it your special treatment before spearing your length into her tight depths. Sliding your hands from the cool wet opening between her legs, you grab hold of the toned cheeks on either side of her tail, kneading the firm, round ass before taking your teasing a step further. Your hand raises slowly, drawing out the moment and anticipation before bringing it down and spanking the siren like you know she loves.");
			
			outputText("\n\nYour hands hit again and again, each hard spank rippling the luscious golden-white rump, and drawing groans and gasps from Minerva every time you plant a new handprint on her round, toned butt. Your kinky siren is loving the teasing spanking, as her tight pink snatch grows wetter and wetter, and her thick, tentacled cock grows harder and harder, sure signs of her greater arousal. \"<i>H-hey! Ahh... how... how long are you going to... ooohh... tease me like this?</i>\" she asks between spanks and moans of delight from the rough teasing.");
			
			outputText("\n\nWith her so wet now, it's the perfect time to strike! Deftly pulling your [armor] from your body, you toss the useless pieces away and expose [eachCock] to the air. Taking hold of [oneCock], you drag its length across Minerva's thighs and rump just to tease her a little more before giving the horny herm the hard dicking she craves. Reaching down, you lift and spread her curvy rear before aligning yourself, your " + player.cockHead(x) + " pressing and kissing her netherlips for a moment, drawing a lusty whimper from the siren before tensing your hips and plowing your iron-hard breeding meat into her with body-jerking power.");
			
			outputText("\n\nDespite your brutal thrust, you slide in with ease, Minerva's tight walls so slickened with her arousal. You squeeze into the deliciously tight herm like butter, easily ramming every inch of your " + player.cockDescript(x) + " into her with only a few hard, deep thrusts. With your hips pressed against Minerva's accepting body, you grind against her, making sure she can feel every inch moving inside her clinging cunt.");
			//If balls: 
			if (player.balls > 0) outputText(" As you continue to pound the siren, your [balls] swing between your legs, the sperm-filled orbs churning with your fertility, preparing to fill the needy siren with every drop you can muster when you let loose your eventual orgasm.");
			
			outputText("\n\nYou give the quivering form under you a gentle pat on the rump, appreciating its feel one last time before you take her. Your hips drive you into Minerva's tight, contracting sex over and over, her tail thrashing with the pleasure she feels for a moment before tightly wrapping around you, not wanting you to pull out of her or even stop your pistoning hips. Your usual teasing and foreplay have done their jobs well, getting the herm so ready for you, so sensitive to your touches that you have her moaning you a serenade, your slippery connection squishing audibly with each heavy thrust.");
			
			outputText("\n\nWith Minerva so ready, you grin with devilish purpose, knowing just what will make this even better. Letting go of her curvy hips, you reach forward and grab her hands, holding the Siren up from behind as you rut her like a hungry beast. Your new, dominant, position seems to only make the well-teased woman enjoy it more, letting her trusted friend and lover take control for a moment, secure in the knowledge that you will keep her safe so she can simply let go and enjoy it. Letting out long moans as she throws her head back, her long red braids thrash around as she gives in, for the moment, allowing the pleasure to consume her. As if they had a mind of their own, Minerva's tentacles lash out from below, slithering around her sizable balls to wrap around your thrusting shaft, the anemone-born organ stinging you with arousal-swelling venom.");
			
			outputText("\n\nGrunting with the sudden heat flooding your blood, you only seem to thrust harder into the red-haired siren, the anemone venom filling you with a deep lust and sexual hunger, your newfound lust spurring your movements. The potent toxin not only fills you with lust, but seems to enlarge your " + player.cockDescript(x) + " with aphrodisiac, making your sexual organ swell longer and thicker inside the siren's slippery snatch. The deep stretching forces a long, throaty moan of pleasure from Minerva as her refreshingly cool cunt is stretched from the sudden thickness. \"<i>F-fuuuck... w-what happened?! Hngh! Fucking me so hard, now... you're like an animaaal!</i>\" the siren practically screams with new ecstasy as you really start to get into the spine-tingling, heart-pounding, nut-busting action with your dangerous new thickness.");
			
			outputText("\n\nWith your body filled with lust, you renew your hip-smacking thrusts, the wet slapping and squishing of your venom-bloated dick stretching her juicy, pink siren-pussy filling the air. It mixes well with the sounds of your grunts and the lyrical moans of pleasure filling the air. A symphony of pleasure and primal satisfaction acting as a testament to your union. Harder and faster you pound into the siren, gripping her wrists tightly from behind to keep your curvy, wanton mate in balance to continue the sexual onslaught of her sopping wet snatch and plant your virile seed deep in her womb in the hope of breeding your siren's needy body.");
			
			outputText("\n\nYour new pace, your brutal, animalistic rutting now so hard and fast, it takes all of Minerva's will to not lose it right then and there! Her orgasm is fast approaching, if her loud, echoing moans are to be believed. The siren's walls tighten, squeezing you in anticipation of her coming climax. Her own cock swells and her balls tighten as they ready themselves to blow her load over the rocks like a pail of spilt milk.");
			
			outputText("\n\nMinerva's need and lust comes to an explosive end as she arches her back, her perky breasts thrusting forward as she lets out a musical cry of delight and cums around you. The siren's cilia-covered walls clench and squeeze, the hundreds of little feelers lining the inside of her cool, slippery snatch writhing and stroking you through her orgasm, trying to milk you for the cum her body knows you have. Between her legs, her tentacle-endowed dick pulsates and bulges as she cums, her male genitalia gushing in unison with her tightly constricting cunt. Her crotch tentacles eagerly go to town on her own dick, stroking and jerking it off as if to milk her own load from her. The thick siren cum splatters, like the thickest of cream, across the rocks.");
			
			outputText("\n\nWith your body so stimulated, so aroused by the tight, passionate fuck, and the potent anemone venom coursing through you, you can't hold out a minute longer under the siren's orgasmic assault. Letting out what can only be described as a primal roar of dominance, you ram your hips against Minerva, letting go of her wrists and grabbing her flanks tightly, spearing your throbbing cockmeat into her desperately quivering quim and let loose your hot, frothy load into her belly.");
			
			//Low-moderate cum: 
			if (player.cumQ() < 500) {
				outputText("\n\nMinerva groans in delight as your seed bursts into her tight, hungry cunt, the tightness of her walls making sure not a drop is wasted, while hundreds of cilia squirm and draw your cum up and into her waiting womb. \"<i>Yesss... let it all out, let me feel your warmth in my belly,</i>\" she demands before her eyes roll back, clearly enjoying the wet heat spreading through her clinging cunt and cum craving womb.");
			}
			//Moderate-high cum:
			else if (player.cumQ() < 1000) {
				outputText("\n\nYour blissful release surges from you like froth from an over-shaken champagne bottle, gushing into Minerva's cunt with such eagerness that it barely needs her thrashing cilia to draw it up into her belly, which becomes visibly bloated after your deposit. \"<i>O-oh! Oh gods! F-fuuuck! That... that's sooo, so much. So hot... so full...</i>\" she babbles, letting out a long satisfied sigh before looking down at her sperm-bloated belly. \"<i>Oh gods... what if... you get me pregnant with all that?</i>\" she croons as she gulps and looks down, a surprisingly happy look on her face. Perhaps she wants you to knock her up?");
			}
			//Holy shit!:
			else {
				outputText("\n\nYour inhuman load fills the siren's accepting belly with what can only be described as a flood, as gallons of your hot spooge instantly bloat her belly, swelling her womb like a balloon of raw fertility.");
				if (player.balls > 0) outputText(" Minerva groans and lets out mindless gurgles as you unload your overproductive balls into her.");  
				outputText(" To even your amazement, her hungry womb is able to contain much of your sperm before she can take no more, each blast of potent cum now gushing from between your bodies, the floor soon looking like someone dumped a barrel full of raw milk on the ground before you're finally done.");
				outputText("\n\nLooking down at her now gravid, overstuffed form, Minerva slowly gets up, only to sit down on the rock and hold her swollen belly in her arms with surprising gentleness. \"<i>Uuugh... oh gods... I feel like I'm gonna burst... Don't think I'll ever get used to this...</i>\" she says with a groan as she looks down at her taut tummy. \"<i>Ooohh... I look like I'm about to give birth to twins... or triplets...</i>\" she says with a small smile on her face, despite how she seems to complain.");
			}
			outputText("\n\nFinally letting go of the well-fucked herm's sides, you ease her into a comfortable rest against the rock, your lust spent into her still quivering body as she pants and sighs with satisfaction. \"<i>That was amazing... I don't know how you do it, but you never cease to amaze, do you?</i>\" she asks with a throaty coo, looking back at you, a deep blush on her face making it clear that she enjoyed everything you did with her.");
			
			outputText("\n\nWith another sigh, she lets go of you with her tail and lays her head on her arms as she leans against the supporting stone. \"<i>I'm sorry, but you know how to wear a girl out... Not that that's a bad thing,</i>\" she says with a giggle, her tail giving you a playful caress this time, just to show how pleased she is. \"<i>I think I'll just rest here for now... on this... mmm... cool stone, where have you been all my life...</i>\" Minerva says with a content smile on her face.");
			
			outputText("\n\nWith an amused grin, you give the sharky herm a pat on the rump before heading out, your hand sliding along that sexy tail of hers as you let the well-fucked woman rest.");
			//PC returns to camp
			dynStats("sen", -1);
			player.orgasm();
			kGAMECLASS.highMountains.minervaScene.tryToImpregnateMinerva();
			dynStats("lus", 20);
			if (getGame().inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		//Choose your hole to be stuffed.
		private function chooseVagOrAss():void {
			if (player.hasVagina()) {
				outputText("\"<i>So, which of your hole would you like me to fuck?</i>\" the siren asks.", true)
				menu();
				addButton(0, "Vagina", minervaLapSex);
				addButton(1, "Ass", getButtFuckedYouSlut);
			}
			else getButtFuckedYouSlut();
		}
		
		//Minerva fucks your pussy!
		private function minervaLapSex():void {
			var x:int = player.cockThatFits(kGAMECLASS.highMountains.minervaScene.minervaACapacity());
			if (x < 0) x = player.smallestCockIndex();
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			flags[kFLAGS.TIMES_MINERVA_SEXED]++;
			outputText(images.showImage("minerva-sex-lapsex-pure"), false);
			outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features. Her legs, her curvy hips... your eyes travel past the thick growing bulge in her shorts, up past her scarred, toned belly and to the siren's large, luscious breasts before finally reaching her face. Grinning to the golden and white herm, you decide what you want from her.");
			
			outputText("\n\nWithout a second thought, you approach Minerva and slide an arm around her bare back, your other hand reaching for her shorts, slowly giving the tight bulge a squeeze and rubbing it, the tentacled organ starting to swell almost instantly. \"<i>Ooohh! Someone knows what they want!</i>\" She grins and puts an arm around you, pulling you against her, \"<i>How about we get started and have some fun?</i>\"");
			
			outputText("\n\nGently pushing you back, Minerva slides her hands up and down her body erotically, her hands touching her bulging shorts before undoing them and stripping them off, her swollen, anemone-like cock nearly bursting out as soon as it is free from its tight prison. Now that her more male organ is free of its confines, it rapidly swells to its full, throbbing sixteen inches. Your eyes can't help but be drawn to the tentacle-endowed flesh, Minerva's tentacles squirming with her obvious excitement. Moving up, she lifts her tube top, releasing her breasts for your enjoyment.");
			
			outputText("\n\n\"<i>Now, let's get these clothes off you and get started,</i>\" she says playfully, before sliding her hands over your body, her hands carefully stripping you of your " + player.armorName + " and tossing it aside. Licking her lips with a grin, Minerva grabs you, pulling you against her cool, naked body, her tentacled phallus pressing against your own body, hard and ready for you; you're surprised that she doesn't just sting you right here and now. Seeing your momentary confusion, Minerva grins and yanks you down on the ground as she gets into position. Suddenly, you find yourself in Minerva's lap with her thick tentacled cock crammed between your bodies, tentacles slowly wiggling against you.");
			
			outputText("\n\nYou're about to ask what Minerva is up to when you suddenly feel something squirming against your [vagina], teasing your nethers with gentle slithering touches. \"<i>Having tentacles down there really comes in handy, don't you think?</i>\" the siren questions with a playful smirk, her dick tentacles squirming their way into your body. They tease and slowly sting you with her aphrodisiac venom, the potent poison injecting right into your sensitive vaginal walls. As soon as your lover's toxins seep into your body, your face and body flush, heating up more and more as the tentacles tease and pleasure you, your feminine sex starting to ooze and dampen with your swelling arousal.");
			
			outputText("\n\nMinerva's hands slide down to grope and squeeze your ass tightly, kneading your [butt] with aggressive fingers. \"<i>You're so damn sexy, you know that?</i>\" she compliments, as her tentacles squirm around inside your body, teasing and stinging you further to help your arousal. The venom inside you, and the feeling of her tentacles, leave you panting and groaning, all the while, her hands explore your body, touching you teasingly.");
			//PC herm: 
			if (player.gender == 3) outputText(" One of her hands trail down to your hard herm " + player.cockDescript(x) + ", stroking you softly.");
			
			outputText("\n\nMinerva's hands grope and squeeze your [fullChest], tweaking your nipples between her fingers. \"<i>Well, now that you're nice and ready, how about we start the main event,</i>\" Minerva whispers into your ear before nibbling it gently.");
			
			outputText("\n\nNodding with a dazed, aroused look on your face, you start to disentangle yourself from the siren, her gentle touch lingering on your skin as her tentacles slip from your body, the slick appendages curling around and slithering across Minerva's dick, lubing it up with your juices for the most fun part of your sexual encounter. Raising yourself, you look down as the tip of her throbbing cock kisses your [vagina]. Taking the opportunity to tease her for a change you reach for Minerva and grab hold of her firm G-cup breasts, your hands groping and squeezing at the delightful chest and pinching her nipples playfully.");
			
			outputText("\n\nShifting your hips back and forth, you tease her tentacled dick, barely keeping yourself from being penetrated, your wet entrance rubbing across the bloated swollen head of Minerva's fuckstick. Finally, you decide it's time to get that thick, venom-packed cock into you. Biting your lip, you start to sink down onto your siren lover's thick, throbbing dick, her hands sliding to your hips and grabbing hold of your ass tightly. Minerva's fat anemone dick stretches your [vagina] wide around its girth as you slowly sink down more and more onto Minerva's cock, your hips getting further into her lap with every inch you take inside you. The siren's hands grope your rump tighter, kneading your [butt] as if to express her need for you.");
			
			outputText("\n\nLetting out a groan, your lover can't seem to take it any longer and pulls you down into her lap.");
			//Nonvirgin: 
			if (!player.hasVirginVagina()) outputText(" The thick siren prick plunges into your soaked cunt and fills your sweltering hole with her oddly cool cock, both of you groaning in delightful pleasure.");
			//Virgin:
			else outputText(" The thick siren prick plunges into your soaked cunt, filling your sweltering pussy with her oddly cool cock, in the process tearing right through your hymen, claiming your first fuck for herself as you bite back a pained yelp, though it is quickly displaced by the pleasure from the stimulation and venom.");
			outputText(" Minerva basks in the feeling of being balls deep in you, and you revel in the feeling of being so filled and stretched while little tentacles squirm inside you and gently sting you with aphrodisiac venom. The build-up of all the arousal enhancing toxins running through your body and the pleasure of the pussy-packing cock squeezed into your twat becomes too much to bear. Your vision explodes with stars and your cunt clenches as you reach an orgasm. Your body shudders and quivers with spine-tingling ecstasy, your nerves alight with furious sensation while your back arches and presses your " + player.chestDesc() + " against your siren lover.");
			player.cuntChange(32,true,true,false);
			
			outputText("\n\nLetting out a gasp at the sudden tightness, Minerva grits her sharky teeth and grips your rear harder, clearly trying to hold back her own orgasm. You could swear you could feel her sizable balls swell in preparation only to be denied. \"<i>Nnnh! That was close... almost blew my load right there! You feel so good around me... so warm around my cock. How do those tentacles feel, hm? The stinging must feel good,</i>\" she says teasingly as she grinds against you, using her grip on you to shift you back and forth slowly and twist her cock inside you.");
			
			outputText("\n\nGrinning to you, she leans in and nibbles your ear gently before licking the outside playfully. Just as your orgasm is ending, your siren lover decides that it's time to get things moving. Gripping you tightly, she starts to pull you off her fat length before slamming you back down hard, the forceful action making your [fullChest] bounce and your [vagina] clench in sudden pleasure. With hard, slow pulls and humps Minerva yanks you up and down, slowly bouncing you in her lap and filling you each time with the squirming, throbbing fullness of her cock.");
			outputText("\n\nIt doesn't take long for the sound of wet flesh squishing together to pervade the air, the slapping of skin coming together with each hard, fast impact when your hips collide with Minerva's. Both of you gasp and groan with pleasure as your pace increases. Leaning you down, Minerva takes a more dominant role, pushing you against the ground without missing a beat, her hips now working against yours as she thrusts into you over and over. Looking up at your siren lover, you can't help but let out a long moan as another dose of her venom is injected into you. With so much inside you, coursing through your blood and making you more sensitive than ever, each hard thrust of Minerva's hips, each grope and touch of her hands across your body, sends shocks of spine-tingling pleasure through your body.");
			
			outputText("\n\nThe eight-foot tall siren grunts hard as she kicks up the pace, her shark tail smacking the ground as she starts to rut you harder. What started as slow and gentle has become a fast and hard, passion-filled fuck. Minerva leans down, capturing your lips in a heated kiss and, despite your lust-addled mind, you can feel the passion and care in the kiss, her delightfully long tongue gently caressing yours even as she pounds you powerfully.");
			
			outputText("\"<i>So good, so good. Yes, yes, yes, how do you like this? Getting fucked so good... mmm... getting your pussy pounded so hard... Nnnngh! Oh gods... here it comes, hun, I'm gonna fuck you s-so full of cum,</i>\" Minerva says to you as she pulls back from the kiss, the need in her voice quite clear. Your lover only lasts a few more hard, powerful thrusts before she gasps, her eyes rolling back into her head as she grips you hard, slamming into you and hilting herself, even as her sizable balls clench and swell again, her thick throbbing cock pulsing inside you, signaling her orgasm. The thick anemone dick seems to bulge with each fat ejaculation, her pent-up balls blowing an immense load inside you, each gush erupting from her tentacle-endowed dick splattering deep inside you, very quickly pooling in your womb and bloating it as more and more fills you.");
			
			outputText("\n\nThe feeling of being stuffed by such a cool, thick, and sticky fluid sends you spiraling over the edge in a mind-blowing orgasm. Back arching and hands gripping the ground as you let out a piercing cry, your [vagina] clenches tightly and quivers around the invading member");
			//PC herm: 
			if (player.hasCock()) {
				outputText(", your own throbbing phallus");
				if (player.cockTotal() > 1) outputText("es");
				outputText(" cumming alongside,");
				//{Low-moderate cum: 
				if (player.cumQ() < 500) outputText(" gushing your cum all over both of your bellies");
				//High cum volume:
				else if (player.cumQ() < 4000) outputText(" splattering thick splooge all over you and Minerva, caking your torsos in fertile jizz");
				//Very high cum:
				else outputText(" exploding out onto your unsuspecting bodies, thick ropes of starkly white sperm gushing over your bodies, quickly dousing both of you in buckets of cum and pooling on the ground");
			}
			outputText(".");
			
			outputText("\n\nMinerva's seed fills you quite full, swelling your belly with what has to be a good liter or two of her thick, musky cream. You have a good feeling you might be pregnant.");
			
			outputText("\n\nPanting from the passionate lovemaking, you both collapse into a sweaty heap on the ground, the wet soothing coolness of Minerva's copious load helping to cool you down. Gently, your siren smiles and leans down, kissing you again before hugging you tightly. \"<i>Mmm, that was so good... I hope I didn't get too rough with you, it's so hard to control myself when I get to have sex with such a sweet and sexy lover,</i>\" she says with an embarrassed smile.");
			
			outputText("\n\nReaching up, you hug your siren, telling her not to worry, and that you loved every second of it. The two of you lay there for a little while, cuddling and basking in a gentle after-sex, embrace.");
			
			outputText("\n\nYou allow Minerva to hold you against her soft body, recovering your strength from the sex you just had. Eventually, though, your strength returns and you gently pry yourself free. Telling her that the sex and her company was wonderful and, despite still being very aroused due to all the venom she stung you with, you need to return to camp.");
			
			if (!kGAMECLASS.highMountains.minervaScene.minervaRomanced()) {
				//Default, first time:
				if (flags[kFLAGS.TIMES_MINERVA_LAPSEXED] == 0) {
					outputText("\n\nMinerva actually seems a little sad that you're leaving. \"<i>I guess you are a busy person. But I'm glad we did this, it was a lot of fun. And... you know... I wouldn't mind if we did this again, soon,</i>\" She suggests with a small, hopeful smile on her face. You promise her that you'll try to come back again soon.");
				}
				//Default, repeated:
				else {
					outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren. \"<i>Well, if you have to go... come back soon, we can do this again if you want! I know I've enjoyed our encounters,</i>\" she insists with a genuine smile on her slightly angular face. You promise her that you'll try to come back again soon.");
				}
			}
			//Romanced:
			else outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face. \"<i>I hope you'll come back soon, I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart.");
			if (rand(100) <= player.totalFertility()) {
				player.knockUpForce(PregnancyStore.PREGNANCY_MINERVA, PregnancyStore.INCUBATION_MINERVA);
			}
			player.slimeFeed();
			flags[kFLAGS.TIMES_MINERVA_LAPSEXED]++;
			player.orgasm();
			dynStats("sen", -1);
			if (getGame().inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		//Minerva fucks your ass!
		private function getButtFuckedYouSlut():void {
			var x:int = player.cockThatFits(kGAMECLASS.highMountains.minervaScene.minervaACapacity());
			if (x < 0) x = player.smallestCockIndex();
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			flags[kFLAGS.TIMES_MINERVA_SEXED]++;
			outputText(images.showImage("minerva-sex-analcatch-pure"), false);
			outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features. Her legs, her curvy hips... your eyes travel past the thick growing bulge in her shorts, up past her scarred, toned belly and to the siren's large, luscious breasts before finally reaching her face. Grinning to the golden and white herm, you decide what you want from her.");
			
			outputText("\n\nWithout a second thought, you approach Minerva and slide an arm around her bare back, your other hand reaching for her shorts, slowly giving the tight bulge a squeeze and rubbing it, the tentacled organ starting to swell almost instantly. \"<i>Ooohh! Someone knows what they want!</i>\" She grins and puts an arm around you, pulling you against her, \"<i>How about we get started and have some fun?</i>\"");
			
			outputText("\n\nGently pushing you back, Minerva slides her hands up and down her body erotically, her hands touching her bulging shorts before undoing them and stripping them off, her swollen, anemone-like cock nearly bursting out as soon as it is free from its tight prison. Now that her more male organ is free of its confines, it rapidly swells to its full, throbbing sixteen inches. Your eyes can't help but be drawn to the tentacle-endowed flesh, Minerva's tentacles squirming with her obvious excitement. Moving up, she lifts her tube top, releasing her breasts for your enjoyment.");
			
			outputText("\n\n\"<i>Now, let's get these clothes off you and get started,</i>\" she says playfully, before sliding her hands over your body, her hands carefully stripping you of your " + player.armorName + " and tossing it aside. Licking her lips with a grin, Minerva grabs you, pulling you against her cool, naked body, her tentacled phallus pressing against your own body, hard and ready for you; you're surprised that she doesn't just sting you right here and now. Seeing your momentary confusion, Minerva grins and yanks you down on the ground as she gets into position. Suddenly, you find yourself in Minerva's lap with her thick tentacled cock crammed between your bodies, tentacles slowly wiggling against you.");
			
			outputText("\n\nYou're about to ask what Minerva is up to when you suddenly feel something squirming against your [asshole], teasing your butt-cheeks with gentle slithering touches. \"<i>Having tentacles down there really comes in handy, don't you think?</i>\" the siren questions with a playful smirk, her dick tentacles squirming their way into your body. They tease and slowly sting you with her aphrodisiac venom, the potent poison injecting right into your sensitive backdoor. As soon as your lover's toxins seep into your body, your face and body flush, heating up more and more as the tentacles tease and pleasure you.");
			
			outputText("\n\nMinerva's hands slide down to grope and squeeze your ass tightly, kneading your [butt] with aggressive fingers. \"<i>You're so damn sexy, you know that?</i>\" she compliments, as her tentacles squirm around inside your body, teasing and stinging you further to help your arousal. The venom inside you, and the feeling of her tentacles, leave you panting and groaning, all the while, her hands explore your body, touching you teasingly.");
			//PC herm: 
			if (player.gender == 3) outputText(" One of her hands trail down to your hard herm " + player.cockDescript(x) + " and " + player.vaginaDescript() + ", stroking and fingering you softly.");
			
			outputText("\n\nMinerva's hands grope and squeeze your [fullChest], tweaking your nipples between her fingers. \"<i>Well, now that you're nice and ready, how about we start the main event,</i>\" Minerva whispers into your ear before nibbling it gently.");
			
			outputText("\n\nNodding with a dazed, aroused look on your face, you start to disentangle yourself from the siren, her gentle touch lingering on your skin as her tentacles slip from your body, the slick appendages curling around and slithering across Minerva's dick, lubing it up with your juices for the most fun part of your sexual encounter. Raising yourself, you look down as the tip of her throbbing cock kisses your [asshole]. Taking the opportunity to tease her for a change you reach for Minerva and grab hold of her firm G-cup breasts, your hands groping and squeezing at the delightful chest and pinching her nipples playfully.");
			
			outputText("\n\nShifting your hips back and forth, you tease her tentacled dick, barely keeping yourself from being penetrated, your rear entrance rubbing across the bloated swollen head of Minerva's fuckstick. Finally, you decide it's time to get that thick, venom-packed cock into you. Biting your lip, you start to sink down onto your siren lover's thick, throbbing dick, her hands sliding to your hips and grabbing hold of your ass tightly. Minerva's fat anemone dick stretches your [asshole] wide around its girth as you slowly sink down more and more onto Minerva's cock, your hips getting further into her lap with every inch you take inside you. The siren's hands grope your rump tighter, kneading your [butt] as if to express her need for you.");
			
			outputText("\n\nLetting out a groan, your lover can't seem to take it any longer and pulls you down into her lap.");
			
			outputText(" The thick siren prick plunges into your backdoor and fills your sweltering hole with her oddly cool cock, both of you groaning in delightful pleasure.");
			player.buttChange(32, true);
			outputText(" Minerva basks in the feeling of being balls deep in you, and you revel in the feeling of being so filled and stretched while little tentacles squirm inside you and gently sting you with aphrodisiac venom. The build-up of all the arousal enhancing toxins running through your body and the pleasure of the butt-packing cock squeezed into your ass becomes too much to bear. Your vision explodes with stars and your ass clenches as you reach an orgasm. Your body shudders and quivers with spine-tingling ecstasy, your nerves alight with furious sensation while your back arches and presses your " + player.chestDesc() + " against your siren lover.");
			
			outputText("\n\nLetting out a gasp at the sudden tightness, Minerva grits her sharky teeth and grips your rear harder, clearly trying to hold back her own orgasm. You could swear you could feel her sizable balls swell in preparation only to be denied. \"<i>Nnnh! That was close... almost blew my load right there! You feel so good around me... so warm around my cock. How do those tentacles feel, hm? The stinging must feel good,</i>\" she says teasingly as she grinds against you, using her grip on you to shift you back and forth slowly and twist her cock inside you.");
			
			outputText("\n\nGrinning to you, she leans in and nibbles your ear gently before licking the outside playfully. Just as your orgasm is ending, your siren lover decides that it's time to get things moving. Gripping you tightly, she starts to pull you off her fat length before slamming you back down hard, the forceful action making your [fullChest] bounce and your [asshole] clench in sudden pleasure. With hard, slow pulls and humps Minerva yanks you up and down, slowly bouncing you in her lap and filling you each time with the squirming, throbbing fullness of her cock.");
			outputText("\n\nIt doesn't take long for the sound of wet flesh squishing together to pervade the air, the slapping of skin coming together with each hard, fast impact when your hips collide with Minerva's. Both of you gasp and groan with pleasure as your pace increases. Leaning you down, Minerva takes a more dominant role, pushing you against the ground without missing a beat, her hips now working against yours as she thrusts into you over and over. Looking up at your siren lover, you can't help but let out a long moan as another dose of her venom is injected into you. With so much inside you, coursing through your blood and making you more sensitive than ever, each hard thrust of Minerva's hips, each grope and touch of her hands across your body, sends shocks of spine-tingling pleasure through your body.");
			
			outputText("\n\nThe eight-foot tall siren grunts hard as she kicks up the pace, her shark tail smacking the ground as she starts to rut you harder. What started as slow and gentle has become a fast and hard, passion-filled fuck. Minerva leans down, capturing your lips in a heated kiss and, despite your lust-addled mind, you can feel the passion and care in the kiss, her delightfully long tongue gently caressing yours even as she pounds you powerfully.");
			
			outputText("\"<i>So good, so good. Yes, yes, yes, how do you like this? Getting fucked so good... mmm... getting your ass pounded so hard... Nnnngh! Oh gods... here it comes, hun, I'm gonna fuck you s-so full of cum,</i>\" Minerva says to you as she pulls back from the kiss, the need in her voice quite clear. Your lover only lasts a few more hard, powerful thrusts before she gasps, her eyes rolling back into her head as she grips you hard, slamming into you and hilting herself, even as her sizable balls clench and swell again, her thick throbbing cock pulsing inside you, signaling her orgasm. The thick anemone dick seems to bulge with each fat ejaculation, her pent-up balls blowing an immense load inside you, each gush erupting from her tentacle-endowed dick splattering deep inside you, very quickly pooling in your bowels and bloating it as more and more fills you.");
			
			outputText("\n\nThe feeling of being stuffed by such a cool, thick, and sticky fluid sends you spiraling over the edge in a mind-blowing orgasm. Back arching and hands gripping the ground as you let out a piercing cry, your [asshole] clenches tightly and quivers around the invading member, ");
			
			if (player.hasVagina()) {
				outputText("your own cunt ");
				if (player.averageVaginalWetness() < 4) outputText("leaking femspunk");
				else outputText("shooting femspunk");
			}	
			if (player.hasVagina() && player.hasCock()) outputText(" while ");
			if (player.hasCock()) {
				outputText("your own throbbing phallus");
				if (player.cockTotal() > 1) outputText("es");
				outputText(" cumming,");
				//{Low-moderate cum: 
				if (player.cumQ() < 500) outputText(" gushing your cum all over both of your bellies");
				//High cum volume:
				else if (player.cumQ() < 4000) outputText(" splattering thick splooge all over you and Minerva, caking your torsos in fertile jizz");
				//Very high cum:
				else outputText(" exploding out onto your unsuspecting bodies, thick ropes of starkly white sperm gushing over your bodies, quickly dousing both of you in buckets of cum and pooling on the ground");
			}

			outputText(".");
			
			outputText("\n\nMinerva's seed fills you quite full, swelling your belly with what has to be a good liter or two of her thick, musky cream.");
			
			outputText("\n\nPanting from the passionate lovemaking, you both collapse into a sweaty heap on the ground, the wet soothing coolness of Minerva's copious load helping to cool you down. Gently, your siren smiles and leans down, kissing you again before hugging you tightly. \"<i>Mmm, that was so good... I hope I didn't get too rough with you, it's so hard to control myself when I get to have sex with such a sweet and sexy lover,</i>\" she says with an embarrassed smile.");
			
			outputText("\n\nReaching up, you hug your siren, telling her not to worry, and that you loved every second of it. The two of you lay there for a little while, cuddling and basking in a gentle after-sex, embrace.");
			
			outputText("\n\nYou allow Minerva to hold you against her soft body, recovering your strength from the sex you just had. Eventually, though, your strength returns and you gently pry yourself free. Telling her that the sex and her company was wonderful and, despite still being very aroused due to all the venom she stung you with, you need to return to camp.");
			
			if (!kGAMECLASS.highMountains.minervaScene.minervaRomanced()) {
				//Default, first time:
				if (flags[kFLAGS.TIMES_MINERVA_LAPSEXED] == 0) {
					outputText("\n\nMinerva actually seems a little sad that you're leaving. \"<i>I guess you are a busy person. But I'm glad we did this, it was a lot of fun. And... you know... I wouldn't mind if we did this again, soon,</i>\" She suggests with a small, hopeful smile on her face. You promise her that you'll try to come back again soon.");
				}
				//Default, repeated:
				else {
					outputText("\n\nSeeing that you have to leave again draws a disappointed sigh from the lonely siren. \"<i>Well, if you have to go... come back soon, we can do this again if you want! I know I've enjoyed our encounters,</i>\" she insists with a genuine smile on her slightly angular face. You promise her that you'll try to come back again soon.");
				}
			}
			//Romanced:
			else outputText("\n\nThe lovestruck siren sighs and sits up, looking up at you with affection clearly written on her face. \"<i>I hope you'll come back soon, I always feel so much happier when you're around,</i>\" she says as she brings a hand to her chest, holding it over her heart.");
			player.slimeFeed();
			flags[kFLAGS.TIMES_MINERVA_LAPSEXED]++;
			player.orgasm();
			dynStats("sen", -1);
			if (getGame().inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		private function goDownOnAHermAndLoveItYouDirtySlutYou():void {
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			flags[kFLAGS.TIMES_MINERVA_SEXED]++;
			outputText(images.showImage("minerva-sex-eatout-pure"), false);
			outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features, starting with her long legs, and her wide, flared hips. Your eyes travel past the thick bulge in her shorts, going up her scarred toned belly and up to the siren's perky G-cup breasts before finally reaching her face. Grinning to the golden-white herm, you tell her you want to give her some pleasure for a change, your words bringing some surprise to her face. \"<i>R-really? You want to focus on me and my pleasure?</i>\" she asks, pleasantly surprised that you want her to be the focus of pleasure this time, a smile full of shark-like teeth soon spreading across her face, \"<i>Well, if you're sure, how could I reject such an offer?</i>\"");
			
			outputText("\n\nLicking your lips in anticipation of the tongue-tingling sexual act you're about to perform on the shark-like herm, you can't help but look forward to tasting the siren's unique flavor. Guiding your lover, you lead her over to the mossy ground that surrounds the pure spring, and help Minerva into the best possible position. The lovely siren moves to her hands and knees, pushing her round, firm ass out for you and spreading her legs as she looks back at you with a violet blush clearly staining her cheeks. \"<i>It's a bit embarrassing with you looking at my ass like that,</i>\" she says as a playful grin slips into her dark glossy lips. You snicker and reach out, grabbing her tight shorts and pulling them down her hips to reveal her shapely golden-white rump, your hands sliding over the firm round cheeks before giving her a squeeze, your touch drawing a mewl from your lover.");
			
			outputText("\n\nLooking up from her delightful rear, you catch a glimpse of the bright blush on her cheeks. \"<i>Is my butt that attractive to you?</i>\" she asks before gently shaking her rear and drawing up her shark tail to wrap around your neck, her actions beckoning you to go through with your lustful plans. To answer her question, you raise a hand and bring it down on her, spanking her ample cheeks and drawing a surprised squeak from her. Not at all finished with her, you grope her rear and kneel down, spreading her knees a little more to give you room to work.");
			
			outputText("\n\nAs you get down between her legs, Minerva pushes her hips higher to help you, clearly looking forward to being the focus of lust this time. Taking a moment, you look at what you have to work with, her smooth, puffy pussy, glistening with her clear arousal, her labia turning a delicate pink to match her wetness. Beneath her feminine sex, you see her male organs, a pair of heavy, sperm-filled balls hanging down, the skin smooth and taut around the highly productive orbs that could pump out many thick loads of cream. Lower still is her throbbing, tentacled cock, the tendrils surrounding the base gently squirming over the length of her shaft and over the tight sack. The long, dexterous things look slick, always ready to sting with her potent, arousing venom.");
			
			outputText("\n\n\"<i>H-hey, what are you doing back there? Having you stare at my junk like that is embarrassing,</i>\" Minerva says. You can't see it, but you're sure she's blushing heavily now. Deciding to put an end to her embarrassment, you slide your hands down from her butt and spread her nethers with your thumbs to get at the soft pink flesh of her inner walls. Leaning in close, you catch the scent of her arousal, and you could swear it smelt a little bit like the peaches that grow from the trees here. The soft scent draws you in, making you wonder if she tastes as good as she smells. You slide your tongue out, drawing it slowly across her spread wet cunt, your tongue pulling a shudder from your shark-like lover as you taste her and discover that she does, indeed, taste a bit like the fruit she consumes so often.");
			
			outputText("\n\nWith her tasting so good, you could really get into this. Your hands take hold of her hips as you dig in, your tongue eagerly lapping up her arousal, each lick sending shocks of sweet delight through her body. Minerva's tail tightens around you, clearly not wanting you to stop your tantalizing tonguing. Her gentle moans reach your ears, telling you how much she is enjoying your attention. Opening your mouth wider, you draw your teeth up, lightly dragging them over her clitoris and eliciting a sharp gasp from your siren lover, all the while licking and teasing her with your tongue.");
			
			outputText("\n\nNot wanting to leave it unattended, your hands drift down, taking hold of her big dick and stroking it, ");
			if (player.tallness < 96) outputText("your fingers not even able to fit around the herm's hefty girth");
			else outputText("your fingers barely wrapping around the meaty member, the fat thing throbbing gently");
			outputText(" as you stroke it slowly. Your touches are clearly adding to your partner's pleasure, her thick masculinity pulsating under your grip, her tentacles reacting to your presence, the dexterous things curling around your hands and fingers, touching you gently, but not stinging you.");
			
			outputText("\n\nNow ready to give her your full attention, you dive in, your lips pressing against her nethers as your tongue slides in, giving her a perverted tongue filled kiss. Your teasing tongue slides in deep and pleasures her inner walls, licking and lapping at every sensitive surface it can reach. As you lick, you can clearly feel the squirming cilia that cover the quivering depths of her cunt, the little squirming things tickling your tongue as you lick. ");
			//Dragon/Demon tongue
			if (player.hasLongTongue()) outputText("Your deliciously long tongue slithers deeper and deeper, reaching sensitive walls and nerves that only the deepest penetrations would reach. The deep licking makes Minerva shudder and let out a long drawn out moan, \"<i>O-oh! Your tongue is so... licking me so deep...</i>\"");
			outputText(" The intimate vaginal kiss is working wonders for the siren. Her sweet, slick juices leak over your tongue, giving you plenty of the peachy flavor that you crave. As you tongue your lover's pussy and tease her clit, your hands work her thick, pulsating cock, pre-cum slowly coating your hands and making it easy for you to squeeze tighter and stroke her faster.");
			
			outputText("\n\nNot wanting her to cum too soon, you pull your mouth back from her tight, cilia-filled snatch, drawing a disappointed moan from Minerva, clearly missing having your tongue inside her. Licking your lips, you can still taste her delightful juices. With your face so close to her genitals and her so close to orgasm, you have a few options to push her over. Dig back into her creamy cunt, or give her needy, swollen balls some attention.");
			
			//[Balls] [No balls]
			//-if balls clicked, use this paragraph
			menu();
			addButton(0,"Balls",lickMinervasBalls);
			addButton(1,"No Balls",noBallsMinervaAndContinuation);
		}

		// Balls
		private function lickMinervasBalls():void {
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			outputText("Not even close to being done, you tease her some more. The tip of your tongue dances along her outer lips before moving down to her smooth, hairless sack to give her male parts some extra attention. Kissing her swollen, taut scrotum, you slowly lick and tease it as your hands work her rock hard shaft. Her fat, sperm-filled balls react to your touch, swelling and pulling up as if getting ready to blow. You can swear you can hear the poor, hefty testicles audibly churning with their thick creamy seed, eager to stuff some poor woman's pussy and impregnate them. Closing your eyes, you latch on, sucking the tight sack and teasing the sensitive orbs inside. \"<i>H-hey, careful down there! Those things are fragile!</i>\" she squawks in delight as you take your time giving the juicy pair some much-needed attention.");
			noBallsMinervaAndContinuation(false);
		}

		// No Balls and continuation
		private function noBallsMinervaAndContinuation(clear:Boolean = true):void {
			if (clear) clearOutput();
			else outputText("\n\n");
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			outputText(images.showImage("minerva-sex-eatout2-pure"), false);
			outputText("Your careful ministrations soon have the poor siren shuddering and squirming, looking about ready to pop from your skilled hands and mouth.");
			if (!clear) outputText(" Retreating from her throbbing balls, you");
			else outputText(" You");
			outputText(" move back up to her now soaking snatch, your tongue eagerly lapping up all the tasty juices from her lips before delving deep into her refreshingly cool cunt, hungrily licking up every slick drop of her succulent sweetness. The act of worming your tongue back inside her hungry hole again drives Minerva ever closer to the brink of her climax, each slurp and stroke of your tongue and hands pushing the near-climactic herm right to the edge and sending her off into the blissful, pleasure-filled abyss of a mind-blowing double orgasm.");
			
			outputText("\n\nLetting out a musical cry of pure ecstasy, Minerva's tail tightens around you as her body locks up, her tail pulling your face right against her convulsing cunt, soaking your face and drowning your mouth in her sticky, peachy juices. Her cilia covered inner walls quiver and squeeze around your tongue, her semi-sweet girlcum flowing over your tongue.");
			
			outputText("\n\nBetween her legs and squeezed in your hands, her thick throbbing cock pulses powerfully. The thick cumvein along the underside bulges with the thick virile ejaculation. Her heavy sack swells and pulls up against her body, seeming to throb and pulse with each gout of thick, creamy seed launched from her mighty cum cannon, the dense load splattering along the ground wastefully, adding to an ever-growing puddle of fertility.");
			
			outputText("\n\nYour lover's shuddering, lyrical cries of utter delight echo through the tower as she cums mind-blowingly hard, your attention to both her genitals giving her two potent orgasms simultaneously. After nearly a minute of constant delight, her climax finally comes to an end.");
			
			outputText("\n\nThe intense sexual crescendo leaves her panting and sweaty as she struggles to stay up, her entire body shaking like jelly. \"<i>Oh... oh, [name], that was amazing. Gods... I came so hard, from both my dick and cunt... You're amazing, you know that, hun? Look at all that seed you made me waste,</i>\" she says, looking back at you with a playful grin. Minerva loosens the hold her tail has on you, giving you the chance to pull back from her juicy nethers");
			//if demonic tongue:
			if (player.tongueType == TONGUE_DEMONIC) outputText(", your perversely prehensile tongue slowly retracting from her quivering quim, rubbing and teasing as it comes out and nearly sending the overly sensitive herm into another climax");
			outputText(".");
			
			outputText("\n\nWith you now released from her grasp, Minerva lets out a sigh and slumps to her side, narrowly missing the thick pool of white splooge on the ground. Her chest rising and falling as she pants, a big smile on her face showing how pleased she is, you can't help but feel a sense of pride at seeing how you were able to satisfy your lover. Even as tired as she is, Minerva keeps a playful grin on her lips, her surprisingly dexterous shark tail being used to yank you down on top of her.");
			
			outputText("\n\nThe siren's arms wrap around you and hugs you against her, with the clear intent on cuddling for a while. \"<i>That was lovely, I'm </i>so<i> glad to have someone that doesn't mind taking care of my needs. Now, how about we cuddle for a bit, we can just lay here together, your head resting at my breast as I cuddle my thoughtful lover,</i>\" she whispers to you softly, and with an invitation like that, how can you say no? Settling into her grasp, you nuzzle her soft cleavage and relax against your siren lover's cool body.");
			
			outputText("\n\nFor a long while, you just lay there, cuddled up with the mostly naked siren, the two of you idly chatting about various things that come to mind. Eventually, you must leave the gentle embrace and return to your duties as a Champion. Disentangling yourself from Minerva, you straighten your clothes out and, with a smile, tell her you had a wonderful time. Grinning up at you, Minerva climbs back onto her feet and pulls you into a deep, tongue-tangling goodbye kiss. \"<i>It was amazing, we have to do this again. Perhaps next time, I can do you, hmm?</i>\" she suggests, not wanting to be greedy and get all the pleasure. Giving you another peck on the cheek, the siren sends you on your way after telling you to come back and visit soon.");
			
			dynStats("lus", 20);
			if (getGame().inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}

		private function letMinervaSuckYouOff():void {
			var x:int = player.cockThatFits(kGAMECLASS.highMountains.minervaScene.minervaVCapacity());
			if (x < 0) x = player.smallestCockIndex();
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			outputText(images.showImage("minerva-sex-blowjob-pure"), false);
			flags[kFLAGS.TIMES_MINERVA_SEXED]++;
			outputText("Thinking about just what kind of heated, heart-pounding, lusty fun you want to have with your siren lover, your eyes look the shark-like harpy up and down, taking in her features. Starting with her long legs, and moving up to her wide, flared hips, your eyes travel past the thick bulge in her shorts, going up her scarred belly to the siren's perky G-cup breasts before finally reaching her face.");
			
			outputText("\n\nGrinning to the golden and white herm you decide what you want from her, your eyes soon falling onto her succulent, glossy black lips, and the long demonic tongue that you know is hidden inside. Grinning and thinking of all the things that tongue could do, you decide you want some nice oral pleasure.");
			
			outputText("\n\nHearing your request brings an unsure look to Minerva's face. \"<i>You want me to suck you off? Well, I guess that wouldn't be so bad... You're sure about this? I mean, aren't you a bit freaked out by my teeth? I promise I would never bite, but still...</i>\" Undeterred by her sharky features, you answer her. You know she would not harm you like that. Guiding her over to one of the fallen pieces of stone, you");
			//If naga: 
			if (player.isNaga()) outputText(" lounge against the rock, spreading open your protective slit and letting your " + player.cockDescript(x) + " hang free.");
			else outputText(" sit down, spreading your [legs] and opening up the crotch of your " + player.armorName + " to the air, letting your " + player.cockDescript(x) + " hang free.");
			
			outputText("\n\nAnxious and ready, Minerva looks down at you before kneeling, placing a hand on your [hips] as she takes hold of your " + player.cockDescript(x) + " and slowly starts to stroke it. Her eyes looking up at you, she leans in and starts to gently lick your hardening flesh with the tip of her tongue. Under her careful, deliberate attentions your manhood is quickly brought to full attention.");
			
			//if cock area 21+:
			if (player.cockArea(x) < 21) {}
			else if (player.cockArea(x) < 34) {
				outputText("\n\nMinerva's eyes widen as your dick grows before her eyes. \"<i>Goodness, you have a pretty good size, don't you? I'm going to make you feel really good.</i>\"");
			}
			//if cock area 34+:
			else if (player.cockArea(x) < 60) outputText("\n\nMinerva's eyes widen as your dick grows and grows, quickly growing almost as large as her own sizable package. \"<i>Wow, you're hung, aren't you? I'll do my best to take everything... wow,</i>\" she says with a blush on her face.");
			//if cock area 60+:
			else outputText("\n\nMinerva's eyes widen and her mouth opens in shock as your dick grows and grows... and grows, quickly dwarfing her own sizable package. \"<i>G-geez, what a huge dick, it's enormous...</i>\" she says with wonder in her voice. Gulping, she licks her lips. \"<i>W-well... I'll do my best to take all of it...</i>\" A little nervousness is mixed into her voice, but with how tall she is, you're sure she could take it all.");
			
			outputText("\n\nTaking a relaxing breath, Minerva dives right into it, her long tongue slithering out to lick your hard, sensitive flesh, wrapping around the tip and giving the most sensitive part of your dick a good squeeze. The heat-quenching chill of her wet tongue feels remarkable on your hard prick, the tight squeeze pulling a gasp from your mouth. Your hands move over her head and into her dark red hair, and you're suddenly relieved that she can't envenom you this way. Wanting to show you what she's made of, your siren leans in, dragging her cool wet tongue up your " + player.cockDescript(x) + " from base to tip before planting a kiss right on the " + player.cockHead(x) + " of your throbbing, needy dick.");
			
			//If balls:
			if (player.balls > 0) outputText(" Her hand on your hip moves down between your legs, sliding inwards to gently caress and massage your cum-filled [balls] to increase your pleasure even more, her hands trying their best to get your nuts worked up and prepare a good load for her at the end.");
			
			outputText("\n\nHolding the kiss for a moment, your siren lover slides her tongue out, slowly teasing around the tip. She look up at you briefly, before a playful smirk slips across her face, her tongue extending from her mouth like a snake, the long appendage coiling around your length and constricting around you tightly, sending shudders of pleasure through your body. The oral embrace feels tight, wet and cool around your comparatively hot dick, the tip of her tongue teasing the underside of your hard flesh");
			//If balls:
			if (player.balls > 0) outputText(" before licking and teasing your [balls]");
			outputText(".");
			
			outputText("\n\nWith your " + player.cockDescript(x) + " firmly captured by her tongue, Minerva leans down, opening her mouth wide and taking you inside its cool, wet confines, even as her tongue squeezes you and slides around your warm, sensitive flesh. Looking up at you with a playful twinkle in her eyes, she starts to suck and squirm her tongue around on you, the long, prehensile appendage switching between licking over your throbbing cockmeat and squeezing it in a snakelike embrace.");
			
			outputText("\n\nPuckering her glossy black lips, Minerva starts to bob her head, taking in more and more of you with each downwards motion");
			//If cockarea 50+:
			if (player.cockArea(x) >= 50) outputText(", your huge cock deep inside her mouth, and soon far down her throat. With some difficulty, her slightly angular nose presses down against your crotch, every inch of your " + player.cockDescript(x) + " trapped inside her cool, wet mouth and throat");
			outputText(".");
			
			outputText("\n\nSlurping and licking your package, she continues to bob her head up and down, working your length with everything she can. Looking down behind her, you can clearly see her shapely rump swaying back and forth, she's clearly not minding the sexual act.");
			
			outputText("\n\nThe furiously teasing tongue-action, coupled with the powerful sucking, leaves you braced against the rock, groaning in sweet pleasure as Minerva works your dick, practically worshiping your manhood, her tongue licking and wrapping around you as she sucks and pulls you deep inside. With how good her mouth is, you're glad she can't sting you with her aphrodisiac in this situation, or she would surely reduce you to a quivering pile of lust.");
			
			//If vagina:
			if (player.hasVagina()) outputText("\n\nExtending her tongue as far as she can, Minerva slithers it further from her mouth and down to your womanhood, her demonic tongue licking around your puffy lips before snaking its way inside to cause you more pleasure, licking and squirming against your walls and making you gasp and quiver under her attentions.");
			
			outputText("\n\nPanting and groaning, you know you can't hold out for long, and you slide your hands into your lover's hair. Your sudden gasping and grabbing hold of her head warn her of your impending orgasm");
			if (player.balls > 0) outputText(", while your [balls] lurch and swell, rising up as you reach your climactic explosion");
			outputText(".");
			
			outputText("\n\nGripping Minerva's head tightly, you let out a long deep moan, your " + player.cockDescript(x) + " bloating with each ejaculation. Eager to please, Minerva does her best to drink down every drop you give her, her hands gripping your [hips] and pressing her nose against your crotch, puckering her full black lips around your [sheath].");
			
			//Low cum: 
			if (player.cumQ() < 500) outputText("\n\nFeeling your orgasm burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, determined to milk as much as she can from you. Not lasting very long, your climax dies down, leaving you panting as Minerva slowly pulls her tongue off of you and licks her lips, leaning back from your saliva-soaked cock. \"<i>Mmm, did you like that? I didn't do too bad, did I? And, you know, you don't taste too bad, either,</i>\" she says with a shark-like grin before licking your tip. \"<i>I wouldn't mind doing this again with you.</i>\"");
			//Moderate cum:
			else if (player.cumQ() < 1000) outputText("\n\nFeeling your orgasm burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, your load slightly bigger than she had thought, your warm seed filling her mouth and completely drenching her tongue in the sticky stuff. Lasting about a minute, your powerful, breathtaking climax dies down as your siren lover swallows one last time, her tongue licking you a bit longer just to make sure, before popping off your saliva-drenched dick. \"<i>Mmm, that was pretty good, and you let out more than I expected! I didn't do too bad, did I? You don't taste too bad either, either, you know</i>\" she says with a shark-like grin before licking your tip. \"<i>I wouldn't mind doing this again with you.</i>\"");
			//High cum: 
			else if (player.cumQ() < 4000) outputText("\n\nFeeling your orgasm suddenly burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, your load notably bigger than she thought it would be, flooding her mouth and puffing out her cheeks, forcing her to struggle to swallow and gulp down your thick, copious load. Lasting well over a minute, your stomach-filling ejaculations finally end, and Minerva pops off your cum hose with a deep sigh, some of your pearly cream running down her chin before being licked up by that delightfully long tongue of hers. \"<i>W-wow... that was quite the load. I'm impressed, I wasn't expecting to get such a... filling meal like this, but you taste pretty good. And I don't think I'm too bad at giving head, either, considering how much I made you cum,</i>\" she says with a shark-like grin and a gentle pat on her slightly swollen tummy. \"<i>I wouldn't mind doing this again with you.</i>\"");
			//holy shit cum volume: 
			else outputText("\n\nFeeling your orgasm suddenly burst inside her, Minerva's long tongue licks up every drop as she keeps sucking you hard, your colossal load far more than she was expecting. Like a great flood, your sperm gushes into her sucking mouth, quickly overflowing Minerva despite her constant swallowing and attempts to contain it, her stomach rapidly bloating under the intense flow. Choking and gagging on the thick cream filling her throat, Minerva squeezes her eyes shut, not about to give up and pull away. She swallows great gulps of your thick, hot cum, but can't catch it all and some begins to gush from her nose and the seal of her lips.\n\nWith your orgasm lasting for what has to be several minutes, you let out a long, satisfied groan as your sperm fountain of a cock is finally released from Minerva's sucking mouth. The filled up siren groans and leans back, a hand on her bloated, cum-stuffed belly, her chest and face plastered with your thick, white cream. Coughing a couple of times to free her throat and sinuses from your jizz, she stares up at you with shock and awe. \"<i>Gods... I had no idea you could cum so much, I've never seen such a potent " + player.mf("male","herm") + " before...</i>\" she chuckles, before coughing some more, \"<i> I don't think I'm going to have to eat dinner tonight, that's for sure...</i>\" she says with a bit of a laugh as she pats her tummy. \"<i>Despite almost drowning me in your cum, I wouldn't mind doing this again with you, you're surprisingly delicious!</i>\"");
			
			outputText("\n\nDeciding to relax for a while after your sexual exertion, you curl up on the soft moss with Minerva, both of you just basking in the warmth that the spring gives off, and the softness of the moss, content with each other's presence. Unfortunately, you know you have to go; the call of your duty to this land is too great, and despite the comfort of this place, you must go. Pulling away from the siren you promise to return and visit her soon.");
			//PC returns to camp.
			player.orgasm();

			if (getGame().inCombat) combat.cleanupAfterCombat();
			else doNext(camp.returnToCampUseOneHour);
		}
		
		//------------------
		//  PREGNANCY
		//------------------
		public function checkPregnancy():void {
			if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation >= 216) {
				if (flags[kFLAGS.MINERVA_CHILDREN] > 0) pregnancyStage1(true);
				else pregnancyStage1(false);
			}
			else if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation >= 144 && kGAMECLASS.highMountains.minervaScene.pregnancy.incubation < 216) {
				if (flags[kFLAGS.MINERVA_CHILDREN] > 0) pregnancyStage2(true);
				else pregnancyStage2(false);
			}
			else if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation >= 72 && kGAMECLASS.highMountains.minervaScene.pregnancy.incubation < 144) {
				if (flags[kFLAGS.MINERVA_CHILDREN] > 0) pregnancyStage3(true);
				else pregnancyStage3(false);
			}
			else if (kGAMECLASS.highMountains.minervaScene.pregnancy.incubation < 72) {
				if (flags[kFLAGS.MINERVA_CHILDREN] > 0) pregnancyStage4(true);
				else pregnancyStage4(false);
			}
		}
		
		//If you've impregnated Minerva.
		public function pregnancyStage1(repeat:Boolean = false):void {
			clearOutput();
			outputText("Even so soon after the act you can clearly make out the noticeable baby bump on Minerva's bare stomach, the telltale sign that she is pregnant. It has barely been a day or so since you could have knocked her up and already she is like this, her pregnancy must progress quickly, probably a legacy of her corrupted state. By the look on the herm's face and by how she practically flutters around like a humming bird, she couldn't possibly be happier. As you look at Minerva she blushes and looks down at her swollen stomach, her hands gently rubbing the bulge in a very tender motherly fashion, her body seeming to radiate a bright mixture of pure joy and maternal pride \"<i>Oh darling, look at this, it's... it's so wonderful, I'm pregnant, I'm really pregnant! Not by some horny beast or demon but by you... my beloved, though you can be a great horny beast sometimes yourself</i>\" she says with a bright sharky grin before bounding over to you, the golden broodmother too excited to contain herself, her wide childbearing hips swaying enticingly, showing off her the fertile bounty of her baby bearing body.");

			if (!repeat){
				outputText("\n\nWith her arms outstretched she bowls into you, glomping onto you like some kind of hug monster, Minerva tackles you to the ground and cuddling you tightly, nuzzling your neck before showering you with kisses all over your face and neck with those succulent black lips of hers. \"<i>Oh [name], my love, I'm so happy. You've given me everything I could dream of, you've given me a family, a real family born from love, not just bestial lust.</i>\" she says with a sniffle, her happiness nearly to the point of tears as she cuddles you like her own personal pillow, the emotional siren pulling you into a deep tongue tangling kiss, her perversely prehensile tongue slithering into your mouth and wrapping around your tongue in a cool gentle embrace.");
				outputText("\n\nWith her grip on you so tight it's clear she doesn't want you going anywhere for some time, so you resign yourself to being trapped in the cool, soft breasty embrace of the siren broodmother. Nearly an hour of cuddling, kissing and snuggling later, Minerva finally pulls back from you, pulling out from one of her tongue filled kisses, her pregnant body pressed against yours tightly and making you feel the delightfully full and very generous curves of her body. \"<i>I'm sorry for keeping you like this for so long, I'm just, you don't know just how happy you've made me.</i>\" Looking down at you she locks eyes with you, her golden-amber eyes alight with the pure fire of her emotions. \"<i>I know I have said it before my love, but I must tell you again, I love you, I swear that I will sing for you and you alone, none else, for you I would love nothing more than to carry your young forever, For you I will birth all the babies you want, I'll never deny you.</i>\" her words ring true, so passionate and unwavering, you can tell that she is absolutely serious.");
			}
			else {
				outputText("\n\nYou feel the smooth caring sensation her hands sliding down your arms, the feeling moving all the way down to your hands, her own guiding yours to the swell of her stomach. \"<i>You've done it again my love, pregnant again with your beautiful offspring, you never fail to knock me up do you, such a potent mate I have. \"<i> she says with a bright-yet-teasing grin. Leaning in she kisses your neck repeatedly as she and you rub her pregnant tummy. Letting out a long sigh she kisses her way to your lips, drawing you into a long dance of tongues as her long prehensile tongue slides into your mouth, coiling around your tongue like a snake to deepen the kiss for a moment.");
				outputText("\n\n\"<i>You never fail do you, always making me happy like this, the shining star in my night sky. I've said it before and I'll say it again my love. I'll never deny you, without a second thought I would happily bare for you a hundred children, a hundred gifts and symbols of your love.</i>\" her soulful words ringing through you, the happy golden herm couldn't be more pleased by how things have turned out.");
				outputText("The maternal hormones clearly affecting her more than ever and the cuddling position, spurring her very active libido, the pressure of her masculinity growing against you betraying her arousal. \"<i>Sorry my love, I get very excited when I think of you and how you've gotten me pregnant so often. You know, we could have some fun if you're up for it.</i>\" she says with a wink.");
				doYesNo(pureMinervaMenu, camp.returnToCampUseOneHour);
				return;
			}
			outputText("\n\nGiving you one final kiss on the lips before finally disentangling herself from you and helping you up, her face brightened by her blush, that grin on her face seemingly unable to be removed. \"<i>Thank you for spending this time with me my love, spending that time with you was very important to me, even now words fail me, I can't tell you happy I am.</i>\" she strokes your cheek softly, holding you there for a moment. \"<i>I know you have to go, back to your important champion duties I know, but... just make sure you come back soon, I wouldn't want you to miss the birth of your baby, or babies by the looks of it.</i>\" she says with a very happy tone, clearly overjoyed at the idea of having more than one growing inside her. Giving you one final long tongue filled kiss she lets you go so that you can head back to your camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function pregnancyStage2(repeat:Boolean = false):void {
			clearOutput();
			if (!repeat) {
				outputText("Looking over the ecstatic siren you could swear she is even happier than before, her belly having doubled in size from before, her gravid form seeming to radiate the joy she feels, her wings fluttering restlessly as if she wants to just take to the air in happiness. Though her belly is growing larger by the day Minerva seems to take it easily, her fertile curvy body seemingly molded and crafted to carry and birth her young with ease, and with such wide hour-glassy hips like hers, childbirth itself should be relatively easier on her. Seeing your eyes wander up and down her body like that brings a blush to her face, the motherly siren looks down at her swollen body and gently rubs the sign of her pregnancy, her touch looking so gentle, like caresses of wonder and reverence.");
				outputText("\n\nWhat with how your last visit went you were sure that she would have immediately tacked you in her joy, unfortunately for you her restlessness and sheer delight could no longer be contained. Letting out a high pitched squeal before running to you, arms spread out she tackles you once again, grabbing you up in a bone crushing hug before spinning the both of you around and around and pulling you into a kiss, a deep hot tongue filled kiss. Her succulent black lips pressed against yours, her long prehensile tongue slithering into your mouth and nearly going down your throat, her hands squeezing you against her voluptuous form. The great swell of her breasts pressing against your " + player.chestDesc() + " her tail even coming around to wrap itself around your " + player.legs() + ". The tight, squeezing, joyful embrace lasting what seems like an eternity, the kiss going on and on as Minerva desperately tries to show you how happy she is to be pregnant with your child, or children judging by the size of her stomach.");
				outputText("\n\nFinally the ache for air wins and the kiss breaks with a wet pop, Minerva's long tongue sliding back inside her mouth before she beams a great sharky grin to you. Leaning in she nuzzles your neck fervently, planting little kisses all over as she presses the swell of her belly against you, letting you feel the product of your fertility and bond with the broodmother. \"<i>Oh darling, oh lover, I just, I can't help it. When you're here and me like this, my tummy so swollen with your children, i just, this is what I have dreamed of. Having a family and you're giving me it.</i>\" she says before resting her head on your shoulder, her face buried in your neck and taking in your scent.");
				outputText("\n\nOnce again on your back with the loving siren woman pressed against you, clinging to you like some breasty hug monster, the tight soft embrace so enticing and warm, it would be hard to pull yourself away even if Minerva didn't have you in such a tight grip. Clearly wanting to snuggle with the father of her children for a while, it's unlikely she will; be letting go anytime soon, and so you resign yourself to your fate of being hugged and cuddled by the busty pregnant broodmother. The huggy herm pulling you into another, though more gentle, kissing session.");
				outputText("\n\nOnce again nearly an hour passes, your time spent in the embrace filled with gentle stroking, kisses, both gentle and tongue tangling, the cool soft cuddle so relaxing you nearly fall asleep, though with all the kisses your kept awake and active throughout. Pulling her lips back from you she slides a hand to your cheek and smiles to you warmly before whispering to you \"<i>I'm sorry for keeping you like this for so long, I'm just, you don't know just how happy you've made me.</i>\" Looking down at you she locks eyes with you, her golden-amber eyes alight with the pure fire of her emotions. \"<i>I know I have said it before my love, but I must tell you again, I love you, I swear that I will sing for you and you alone, none else, for you I would love nothing more than to carry your young forever, For you I will birth all the babies you want, I'll never deny you.</i>\" her words ring true, so passionate and unwavering, you can tell that she is absolutely serious.");
				outputText("\n\nGiving you one final kiss on the lips before finally disentangling herself from you and helping you up, her face brightened by her blush, that grin on her face seemingly unable to be removed. \"<i>Mhm thank you for spending this time with me my love. Even now words fail me, there is no way to describe how happy you have made me for blessing me...mhm...no.</i>\" Minerva stops and pulls you closer, leaning in herself to plant the sweetest of kisses on your lips before continuing. \"<i>Blessing us with the precious gift that's growing inside me.</i>\" she strokes your cheek softly, holding you there for a moment. \"<i>I know you have to go, back to your important champion duties I know, but... just make sure you come back soon, I wouldn't want you to miss the birth of your your baby, or babies by the looks of it.</i>\" she says with a very happy tone, clearly overjoyed at the idea of having more than one growing inside her. Giving you one final long tongue filled kiss she lets you go so that you can head back to your camp.");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			else {
				outputText("As always Minerva's pregnancy is swift, already her belly swells roundly with your children, the product of your passion and bond with the fertile broodmother. As you look her once again pregnant body up and down you can see how pleased she is, her hands tenderly rubbing the swell of her tummy with maternal gentleness, the warm smile she has as she looks between you and her body, a blush growing on cheeks as you look at her. Letting out a soft dove like coo, Minerva settles herself down on a seat like rock by the spring, her golden-amber eyes locking onto yours, silently beckoning you to come to her as she hold and strokes her body.");
				outputText("\n\nGrinning you come to her this time, approaching the pregnant herm to get a closer look at her. Looking up at you with glittering eyes, Minerva reaches out to you, taking gentle hold of your hands and guiding them to her round graved swell. \"<i>My love, they grow so quickly, our daughters. I can't wait to see them, for you to see them; they will be just as beautiful and energetic as their sisters. Already so active inside me, I have to sing them to sleep just so they will stop fidgeting inside my belly, they can't wait to come out and see their daddy I'm sure.</i>\" she says with a bright sharky grin before leaning up, her hands sliding up your arms before wrapping around your neck and pulling you into a deep kiss. Behind Minerva, her wings twitch and rustle, moving alongside her swaying anxious tail, making it easy to tell how restless she is and that she wants to hold her new daughters in her arms.");
				outputText("\n\nFinally releasing you from the long drawn out kiss, pretty pregnant siren pulls you down onto her with a grin, pulling you so you're sitting in her lap with her big round belly pressed against you. \"<i>You know... all these motherly feelings and hormones are doing crazy things to me, I'm making so much milk now, I bet I could feed half a dozen little ones, you know...would you... care for a taste my love? Before our new daughters drink it all up?</i>\" She says with a devilish grin, her hands rising to her chest and pulling her top down, letting her big full breasts burst free, you could swear the hefty jugs were bigger than usual, each breast round and heavy with all the milk trapped inside.");
				outputText("\n\nWith the fertile milky melons on full display, nipples hard and ready in anticipation of feeding all her little daughters and the one who gave her such darling babies, with such massive motherly mammaries on full display and the offer of a belly full of Minerva's peachy milk, how could you say no? Licking your lips you lean down, your hands gliding over the firm globes of maternal delights, your lips puckering, and planting small kisses around the swollen areola, your tongue sliding out to tease and lick around the hard nipple. Your sweet teases drawing gentle bird like coos and soft sighs from the pregnant broodmother, her body more than ready to feed you and fill you with her cool creamy milk. The thought of your meal so close soon becomes too tempting, your lips latching onto the breast, your tongue flicking the nipple gently before starting to suckle. Thankfully you don't have to wait long, very soon the milk flows over your tongue, creamy rivers of sweet peachy milk filling your mouth with refreshing coolness and running freely down your throat as if to quench a great thirst.");
				player.refillHunger(10);
				outputText("\n\nLost in the maternal embrace, Minerva hold you gently against her, her hands stroking your head softly, fingers running through your hair and tickling you lightly with her feathers. Drinking greedily, your hands gently knead the full firm breast as you suckle and tease her with your tongue. As you suck the milky breast you hear your pregnant lover change, her breaths quicken, a deep blush rising to her face and very soon you can feel the hard pressure of her thick sick growing against you, the pressure growing and growing until the siren is at full throbbing hardness, the silky sarong having been shoved aside by the needy cock. You can't help but grin at your work, your ability to get her so horny and wanting so easily, pulling back you look at her blushing face, her eyes alight with the fire of her arousal. \"<i>Oh darling... that was so... so good, mmmm... you've gotten me so hot, come on lover, let's have some fun, what do you say? Wanna fuck your beautiful pregnant siren and rock your daughters to sleep in her belly?</i>\"");
				outputText("\n\nSeeing how aroused you've gotten her it would be rude to just leave her like this. Grinning you grab her iron hard erection and give it a squeeze, drawing a long throaty moan from Minerva. Your touch is all the answer she needs.");
				pureMinervaSexMenu();
				return;
			}
			doNext(camp.returnToCampUseOneHour); //Failsafe 
		}
		
		public function pregnancyStage3(repeat:Boolean = false):void {
			clearOutput();
			if (!repeat) {
				outputText("Once again you find yourself admiring Minerva's growing pregnancy, though its hard to get a good look when the siren is fluttering around her tower like a nervous hummingbird, though in her case you say its more out of excitement then nervousness. The heavily pregnant herm can hardly stand still, her wings fluttering, her tail wagging and hands fidgeting. Seeing your intense gaze she blushes and bites her lips before taking a deep breath, choosing to focus once more on the now huge rounded swell of the babies growing inside her, her belly gotten so large now that even she seems to have a little trouble with it.");
				outputText("\n\nWith her gaze now focused on her belly Minerva visibly calms down, her hands cradling the great swell with all the gentleness of a proud mother, her hands tenderly rubbing and stroking it even as her eyes lift and look at you, a great smile on her face as she looks at you. Finally closing the gap your lover approaches you, her hips swinging wide with the new weight of your offspring. Moving quickly she presses herself against you, her arms sliding around you as she looks into your eyes, the passionate flames of her love for you burning so clearly in the golden amber orbs. \"<i>My love, I'm...I'm so glad you could visit. I've gotten so big now, I know its close. I... I can hardly believe it, I'm going to give birth soon, your beautiful children.</i>\" she says, her voice wavering gently and betraying her emotions.");
				outputText("\n\nWith tears in her eyes she tightens her hold, burying her face in your neck and cuddling you tightly, the joyful herm so full of raw emotion that she's bursting at the seams. You can feel her cool tears on your skin as she kisses your neck. \"<i>Oh darling, it's so amazing, I cant believe its so close already, all I've been thinking about is how I'm finally going to have a real family of my own. I'll make sure these children of ours, all of them, no matter how many you want, will be taken care of, I'll be the greatest mother they could have.</i>\" Minerva's words sounding so definite so strong despite her raging emotions, there is no doubt that she will care for your children and give them all the love they could ever want.");
				outputText("\n\nSlipping your arms around her, you cradle the heavily pregnant siren in your arms, your hands stroking her softly before sliding down her soft feathered arms before resting on her big round belly, almost as soon as you touch it you can feel the kicking and squirming of the energetic young inside, the unborn babies seeming to react to your touch as if they knew their daddy was right there. Minerva pulls herself from your neck, her face damp from her tears as she smiles to you, the smile quickly growing into the bright grin you that's becoming so familiar. \"<i>They get so restless my love, kicking up a storm and squirming so frequently now, I'm sure they know the time is close. soon they will be born and will get to meet their big strong daddy, they are going to love you I know it. I bet they will cling to you like nothing else.</i>\" she says before leaning in and kissing you softly. \"<i>Just like how I can't help but cling to you</i>\" the siren whispers to you softly before closing the gap and pulling you into a long kiss, her body moving and gently moving both of you onto the ground, laying on the soft pillow like moss together as you kiss and cuddle.");

				outputText("\n\nThe pair of you lay there together just cuddled together, kissing as you gently rub and stroke Minerva's pregnant swell, the golden siren responding to your gentle ministrations with soft dove like coos of delight. Wanting to take this further you help her up, guiding her to");
				if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) outputText("the huge oak tree that dominates the spring, sitting her down with her back against the trunk of the tree.");
				else outputText("one of the ever growing fruit trees, laying her down against the trunk of the fruit bearing trees.");

				outputText("\n\nWith Minerva now in a more comfortable position with her fertile swollen tummy cradled in her arms you're now able to make sure she and your unborn are happy and comfortable.");
				outputText("\n\nMoving down Minerva's body you plant tender kisses across her, moving from her lips, down between the full motherly swell of her breasts, stopping at the big round pregnant tummy. Smiling up at her you start to stroke her, caressing the soon-to-be mother's tummy and and your offspring that sleep within. Leaning in you start to kiss her belly, laying tender affections upon the siren that make her blush furiously and start to stroke your [hair] softly. \"<i>Oh darling, that's wonderful, mmmm that's actually very relaxing.</i>\" Minerva says gently as she lays her head back, watching you with warm loving eyes as you pay special attention to her pregnancy.");
				outputText("\n\nMiraculously your touch seems to relax even the rambunctious babies inside Minerva's body, the little ones inside calming their squirms and kicks as if they know their daddy is there and paying special attention to them and their mommy. Before long the kicking and squirming stops completely, the little critters inside Minerva's tummy fast asleep thanks to their daddy, in fact your efforts to calm the excited babies has had more of an effect them you thought, Minerva herself has nodded off, her head resting against the tree , hands still cradling her belly gently even while asleep. Snickering to yourself you look around before moving up closer, taking your place next to Minerva, deciding that you may as well have a nap and spend a little more time with the siren.");
				outputText("\n\nFor nearly an hour you sleep with Minerva, yawning as you awaken from your nap you look to see that Minerva has cuddled up against you, her round baby baring belly pressed against your body with her arms, and even one of her legs, wrapped around you. The golden herm looking so peaceful, if more than a little horny, as if she wanted nothing more than to be curled up with you forever, but unfortunately you can't stay much longer and have to get back to your duties. Not wanting to wake the herm up you oh so carefully disentangle yourself from her without waking the broodmother, not a small feat by any means. With your skill your able to come free of her hold, not wanting to simply leave her like this though, you pull a blanket from your pack and drape it over her body, leaning in you plant a soft kiss on her lips before taking your leave. With her pregnancy so close to being over, you make a note to return soon so that you can witness the birth of your children.");
				doNext(camp.returnToCampUseOneHour);
				return;
			}
			else {
				outputText("Showing such interest in Minerva's great swollen form clearly pleases the obviously hormonally horny herm, now what she is much more used to being pregnant Minerva is far more aware of her hormone addled body. The joy of being so pregnant with your offspring greatly enhancing her already considerable libido, the scent of her arousal clear in the air as she licks her lips, her eyes locked on you like a predator eyeing up its next meal, and while the siren is very much a hungry meat eating predator, you have no doubt that she isn't hungry for food.");
				outputText("\n\nGrinning her usual sharky grin Minerva strides towards you, her wide fertile hips swaying side to side, clearly showing off her childbearing body for your enjoyment, the great swell of her pregnancy on full display. Just above, her milk engorged breasts strain against the tight white top, her nipples standing against the fabric to help show you how aroused she is, what's more defined though is the iron hard erection that bobs with each step, the thick shaft rubbing against her swollen tummy, the constant rubbing keeping the cream and gold cock at full arousal. Only adding to the sight are the clear feminine juices running down her inner thighs and showing just how slick and ready she must be, the slippery female lubricant intensifying the already strong scent of the fertile needy herm \"<i>oh darling! Like what you see? Look at how big I am now, your babies growing so fast inside me.</i>\" she says with a deep throaty purr as she reaches out, sliding her body against yours and pressing herself against you. \"<i>Oh lover, I know it's sudden, but I'm so horny, your little ones always get me so hot and bothered, I know I can't get any more pregnant than I am now but I want you, I want you so bad, my pregnant body craves the touch of the one who impregnated me.</i>\" she says as her hands roam over your body, trailing down your " + player.chestDesc() + " and heading down to the crotch of your " + player.armorName + " before giving you a squeeze.");
				outputText("\n\n\"<i>Come my love, take your Minerva for a spin, she needs relief so badly.</i>\" the horny herm says as she grinds against you, her massive milky mammaries and throbbing siren cock rubbing against you as she tries to tempt you with her pregnant body. \"<i>It's your babies that are doing this to me, filling me with such need, such hunger for you, only your touch will satisfy the fire raging inside me.</i>\" she ends with whisper, her full pouty black lips right at your ear, her tongue slithering out to lick along the outside. One of Minerva's hands slips into your " + player.armorName + ", sneaking down and grabbing hold of your hardening " + player.cockDescript() + " her aggressive advances and powerful scent arousing you and almost compelling you to act on her needs.");
				outputText("\n\nYour breeder's instincts paired with the deep tender affections you have for the siren, the same ones that drove you to impregnate the supremely fertile broodmother in the first place, kicking into overdrive with her coming onto you so strongly, and her bewitching scent filling your head as she teases you with your body. The call to rut the curvy demanding affectionate herm and fill her full of your potent virile seed is too strong. Giving into the sweet accepting temptation your hands slide over her delightful body, sneaking behind her and giving her round taut peach of an ass a hard spank for teasing you so much, the sharp sting pulling a squeak of surprise followed by a deep throaty coo of desire. Gripping you tightly Minerva pulls you against her hard, mashing her lips against yours in a furious needy kiss, her tongue slipping into your mouth, coiling around your own and even going down your throat for a deepthroat kiss, her hands roaming over your body and stroking your " + player.cockDescript() + " through your attire. Soon the need is too great for Minerva, her hands nearly tearing the " + player.armorName + " from your body, tossing her own clothes aside as if they were trash she licks her lips with clear need. Letting out a long moan her hands slide over her body, from her wide hips all the way to her big milky tits and squeezing them just to tease you some more.");
				outputText("\n\nGrinning her trademark sharky grin, Minerva approaches you once more, this time however she pushes you down, intent on having a little fun with you before getting to the real meat of the no doubt intense fuckfest this will dissolve into. With you laying on the soft moss like this, your hard " + player.cockDescript() + " ready and waiting between your legs, you're in the perfect position for the hungry siren to have her way with you, crawling over you, tail waving in the air as she moves closer and closer. Her hands slide over your thighs and [hips] and spreading them wide as she slips between them, that perversely prehensile tongue sliding out from her full glossy black lips and snaking its way towards your hardening prick.");
				outputText("\n\nWith agonizing slowness the long snaking tongue licks you, running from base to tip, the herm deliberately working to tease you as much as she can. Leaning in closely that tongue starts to coil around and around the shaft of your pick, squeezing it even as Minerva leans over the engorged erection and plants a kiss right on the tip. The kinky kiss quickly evolving into something far more pleasurable, her mouth descending upon your pillar of hard tongue wrapped flesh until you're completely enclosed within her cool wet mouth, her tongue squeezing you even as she sucks on your sensitive cock. Biting your lip you can't help but let out a long groan, the tight tongue wrapped confines of the siren's eager mouth are too good to ignore, the way the tongue squeezes all around the shaft, the tip tickling and teasing the head as she sucks the whole thing.");
				outputText("\n\nClearly not setting for simply giving you a blow job, Minerva slowly pulls back, her tongue sliding off you and freeing you of her tonguey prison with a long drawn out slurp. \"<i>Mmmm... always so tasty, I have something special for you my love, how about we take these big milk jugs of mine for a spin.</i>\" she says as she hefts up the heavy round orbs with her hands. Getting into position she nestles your " + player.cockDescript() + " in between the cool soft masses of her huge H-cup tits and squeezes them together with her hands, trapping your achingly hard dick between the motherly mammaries. Grinning to you she leans down, lips puckered in preparation as she licks around the tip of the engorged member popping out from the top of her expansive cleavage, closing the distance she plants a kiss on the [cockhead] again before sucking on the sensitive glands and starting to pump her breasts up and down against your length.");
				outputText("\n\nWith so much stimulation soon all you can think about is the soft pillowy embrace of Minerva's boobjob, the soft sucking of Minerva's glossy puckered lips on your head, sucking it softly while her tongue tickles the sensitive slit of your urethra and teases the crown of your " + player.cockDescript() + ". Popping off for a breath with a lusty look in her eyes, saliva drooling from the corner of her full kissable lips at the taste of you heady flavor. Pulling her hands up, she presses her palms into the heavy milk filled weight of breasts, her hands sinking into the firm soft jugs, held back from being sucked into their softness by the firm pressure of all her milk. With how much she teases you only to bring you such pleasure you glad she didn't drug you with her potent tentacle toxin beforehand, knowing you should surely blow your load under the attentions of such glorious udders and teasing, tongue filled kisses from your red haired matron.");
				outputText("\n\nFull, slippery lips slide back around you again, further sucking on you your bloated cock while holding you into their full pitch black embrace. It's enough to make you swoon and flare, growing thicker inside her smothering mounds while she pumps at you with her milky mammaries. Minerva lets out throat coos in between sucking on your dick-tip, showing off how eager she is to have you in such a pleasurable embrace \"<i>Mmm, such a yummy fertile cock you have my love, so hard, so ready to let out your thick virile load. Let my heavy creamy tits help milk out all that yummy cum from your cock, I want you to build up such a big hot cum bath and sate my body's burning need for you.</i>\"");
				outputText("\n\nYou gasp and groan, pumping your hips into her bountiful breasts, desperate for the sweet pleasurable release. Seeing the hunger in your eyes only seems to turn the horny pregnant siren on even more, her hips shifting back and forth, her tail sliding between her legs to stroke and rub her slippery pussy to get her cool cunt ready for what would be coming. Lusting for what you would give her, Minerva sinks down on your cock, her puffy lips closing around the head of your dick as she pumps her breasts, her mouth sucking hard while her tongue teases all around your sensitive glands.");
				if (player.balls > 0) outputText("\n\nSliding between your legs, her hands stroke and caress your " + player.ballDescript() + ". gently kneading and massaging the seed filled nuts with tender softness to coax your future climax to its fullest");
				outputText("\n\nOnce again Minerva pulls back, denying you and letting you save your precious load for something special. \"<i>Sorry to leave you hanging like this darling, but I want that big load to go where it belongs, right into my fertile pussy and womb, I know it's a bit occupied at the moment, but don't let that bother you, I'm sure our daughters wouldn't mind a bit, in fact I think they may enjoy the warmth of a bath in their daddies hot virile spunk.</i>\" she says teasingly and with a kinky grin as she lets go of your cock, giving it one last kiss before fully letting go. Growing in supreme disappointment and the ache in your loins, you were so close to cuming when the golden herm pulled away, your seed so backed up now from two near orgasms, your cock painfully engorged and hard now");
				outputText("\n\nThankfully you don't have to wait long for your lover to continue. The heavily pregnant siren steps over you, kneeling over your body, her cool arousal dripping snatch just kissing the top of your dick. Licking her lips she looks down at you with a predatory gaze, her dick's tentacles squirming with excitement, the long things curling around your " + player.cockDescript() + ", you know just what she is going to do to you. Eyes widening at the prospect of what's going to happen you try to speak, try to call her off but its too late. Letting out a sharp cry of utter delight Minerva rams her hips down, spearing herself upon every inch of your shaft, her tentacles and pussy cilia all stinging you at once, with how pent up you are and with the venom surging into your body you can't contain yourself any longer. Back arching, eyes rolling back you explode into your climax, huge pent up jets of your seed burst from your body even as the venom causes your cock to swell up inside the needy siren and clog her tight squeezing tunnel with your bloated thickness. Your thick wide cumvein bloating and bulging with every heavy sperm filled ejaculation, your lover's potent venom enhancing your already powerful orgasm even as you blow your load, ensuring her pussy and womb would be filled with your seed.");
				outputText("\n\nYour lover above you clutching her swollen pregnant belly as you cum your brains out, her hands running over the bulging swell with delighted ecstasy, her great wide hips rocking back and forth, her tight hungry cunt clenching and squeezing you, her long tentacles and squeezing cilia springing you over and over, pumping your body so full of her toxic cocktail that all you can think about is breeding the needy woman over and over. With how much of the trademark siren poison inside you it doesn't take you long to completely stuff Minerva's tight slippery snatch and the pregnant woman couldn't be happier with that fact. Her rocking hips now starting to bounce her up and down over you even as your orgasm starts to slow.");
				if (player.balls > 0) outputText("Despite how much you just came your massive venom filled testicles are still achingly bloated with seed, Minerva's overzealous stinging demanding that you fill her over and over to sate her desperate hormone driven need");
				outputText("\n\nWith her huge round tummy bloated with your babies, and now what has to be a good few liters of thick ball batter, you would think she would have trouble moving but the happy pleasure filled herm bounces up and down over your engorged prick like no tomorrow. The sirens lyrical moans and cries soon fill the air, mixing with the wet slurping her slippery pussy makes each time she slams her hips down upon you over and over, the sound combining to make a beautiful perverted symphony of lust and need, the erotic sounds only serving to flare your lust even more.");
				outputText("\n\nWith your mind in the tight grip of your immense drug driven lust you're every thought is dominated by the need to breed, your hands grabbing hold of the sirens fertile hips tightly as she rides you like a bucking animal. Hips bouncing, full heavy breasts jiggling, fiery braided hair thrashing with each movement, even though the pleasure filled have Minerva lovingly cradles her huge pregnant belly. \"<i>Oh gods! Oh fuck! D-darling, so...so fuuuuck. It's so good; your [cock] is so good, stretching me so much. Ooohhh.. My poor belly, so full...so full of your spunk, so heavy with your beautiful babies!</i>\" she nearly screams right before she herself finally cums, her body shaking and quivering in mind cracking ecstasy. Despite the crushing grip of her walls Minerva continues to ride you all through her orgasm thanks to the sheer amount of slippery feminine juices flowing from her ravenous cunt. Her tentacles along with the squirming grippy cilia squeeze down on you as they inject your already bloated dick with fresh dose of venom. The new overdose levels of aphrodisiac toxin inside you forcing you into a second pussy packing orgasm.");
				outputText("\n\nYour swollen, painfully hard manhood seems to swell just a little more as your seed explodes from you, your thick cumvein bulging and bloating as each massive gush of pent up sperm.");
				if (player.balls > 0) outputText(" Thankfully your aching swollen nuts shrink with each geyser like gush you let loose from your massively swollen prick, though if anything it only seems to mitigate the effects of all the siren venom inside you not stop it and soon your balls will merely refill."); 
				outputText(" As soon as she feels the seed filling her again Minerva bursts into a seconds orgasm, her wings flaring out as she rams her hips down against your own, her feet sliding underneath you as she clenches her hips and thighs, crushing herself against you as her body squeezes and milks your swollen pulsating prick for every drop you can give. The new found pressure keeping much of your second load contained within the tight hungry confines of her womb. \"<i>Yes! Yesss! Fill me! Fill me so much! Give our babies all the cream they want! Make them swim in it!</i>\" the wanton herm screams as she cums so hard above you, demanding that you fill her up with everything you can muster.");
				outputText("\n\nThough her womb swells with the immense load Minerva can only hold so much inside, the remainder of your pressurized load gushing out in great spurts from between your fleshy connection, a small pool soaking your hips and thighs as you finally finish your orgasm. Despite how much you have done already neither of you are even close to being done, Minerva's hormone flooded body craving more pleasure, more sex to feed her insatiable craving for your fertile cock cream, your own body still roiling with incredible lust thanks to all the siren venom inside you, your need to rut and breed not allowing you rest.");
				outputText("\n\nAs if to emphasize how much she wants you Minerva lifts off you with a wet sloppy pop, a rush of thick jizz flows like a waterfall from her soaking cunt as she gets down onto her hands and knees, chest resting on her big milky tits with her arms cradling the massive bulge of her belly. With her round juicy ass presented so wonderfully to you, the taut round peach of gold and cream flesh swaying back and forth as her tail rises and legs spread. \"<i>More lover! Fuck your siren, let out all your lust, breed my hungry golden pussy!</i>\" her words are the last straw that breaks your restrains, grabbing hold of her hips you get up from your position and ram yourself back inside with a wet squish of combined sexual juices as you continue the ravenous rut, the overpowered need to mate and breed could keep you both like this for hours.");
				player.orgasm();
				doNext(postPregnancyStage3Sex);
				return;
			}
			doNext(camp.returnToCampUseOneHour); //Failsafe
		}
		
		private function postPregnancyStage3Sex():void {
			clearOutput();
			outputText("Indeed your insatiable lusts kept up for several hours, the pair of you rutting like wild animals, by the time you had finally filled Minerva's belly for the last time you lost count of the orgasms you each had, seven, ten? The siren in question had been rendered into a moaning, sweaty cum caked mess on the floor, her pregnant body completely drenched in your sperm and each of her gaping dick milking holes leaking the thick white cream. For how completely exhausted the pair of you are neither of you could be happier. \"<i>shhoo... shhooooo....gooood...</i>\" was all Minerva could say as she slumps against one of the trees, slowly starting to use her long prehensile tongue to start cleaning herself off, slowly licking all your seed from her voluptuous pregnant body. Shaking your head you have no idea how you're not dead from dehydration by cumming so much, but at least all the siren venom is cleaned out of your system, the stuff may have a powerful effect but it burns itself off quickly, you're sure Minerva had to have kept stinging you throughout the whole thing to keep you going.");
			outputText("\n\nLooking over to you Minerva smiled, a bright blush on her now clean face, reaching out for you she pulls you over to her, helping you by resting you against the tree. \"<i>I guess we went a bit too far huh? I've never felt so satisfied in my life! Here let me help you, I'll clean you up and then, how about we rest, you can stay the night even! Rest up and relax a little?</i>\" she asks with a smile and a hopeful glitter in her golden-amber eyes. Letting out a sigh you nod your head, too tired from the crazy sex-a-thon you and Minerva just went through to fight, perhaps a good sleep will fix you right up.");
			outputText("\n\nGrinning ear to ear, Minerva seems to be somewhat revitalized by your acceptance, pulling you closer the siren broodmother gets to work on you, her tongue happily licking up the cum caked mess that is your body. It's a big job but before long you're mostly cleaned, if a little damp from the licking. Letting out a deep sigh your lover relaxes next to you, her arms cradling her massive belly, swollen by not only your soon to be birthed offspring but what you can only guess has to be perhaps a dozen liters of thick sticky baby cream. As if sensing your thoughts Minerva pats her belly gently. \"<i>So warm, I've never felt so full before in my life. You know, as perverted as it is, I'm sure the little ones appreciate the warmth, even if they are swimming in their daddy's sperm...</i>\" she says before shaking her head. \"<i>Well no matter. Let's just...rest for a while...</i>\" The tired siren says before cuddling up against her, her freshly cleaned body still so swollen with your fresh sperm injections, it will be some time before she absorbs it all. For now though all you can think of is resisting, the urge to sleep soon overcoming you as your head rests against Minerva's shoulder.");
			cheatTime(1); //Ensure that the clock is not at 6am to prevent weirdness.
			player.orgasm();
			player.changeFatigue(30);
			doNext(postPregnancyStage3Sleep);
		}
		private function postPregnancyStage3Sleep():void {
			processSleepTime();
			outputText("You awaken the next morning actually feeling rather refreshed, the scent of sweet peaches fill the air, following your nose you don't have to look for long to find where the smell is coming from. In fact you don't even have to get up! Minerva is right there by your side with some freshly picked peaches from her trees, the golden herm dressed in her usual skimpy attire and in fact you yourself have your clothes back on, could Minerva have redressed you while you were passed out asleep. Grinning at your confusion, the siren broodmother kissing your cheek and speaks. \"<i>Good morning, sleepy head, you were out for a while, guess we were more tired than we thought, well these should perk you up, my peaches are guaranteed to boost your energy, go head love, freshly picked and oh so sweet!</i>\" she says before sitting with you.");
			outputText("\n\nNodding in acceptance you happily bite into the sweet, juicy fruit. Once you taste that delicious fruit you can't help but wolf it down, the juices running down your chin as they quench your thirst, the tasty flesh helping to sate the hunger that pains your stomach. You eat your fill of the sweet fruit, Minerva handing you a peach each time you finish until you're full and satisfied once more. ");
			player.slimeFeed();
			player.refillHunger(100);
			player.changeFatigue(-100);
			outputText(" ");
			HPChange(player.maxHP(), true)
			outputText("\nWith you fed and rested, the golden broodmother helps you to your feet, despite all the sleep you got; your legs are still a bit wobbly. Thankfully Minerva helps you steady yourself. \"< i > My goodness, are you alright? I guess you're not quite recovered are you, are you sure you don't want to rest more? < / i >\" the gentle maternal herm asks you, knowing that you must get back to your important work soon.");

			outputText("\n\nDespite the feeling in your legs you nod your head in affirmation, while it would be nice to rest you have much to do, demons to slay, damsels to save from said demons. Smiling at the strong front you give, Minerva pulls you into a hug. \"<i>That's my strong hero, so brave, so strong. I just know you will save this world and soon there will be some more sirens in the world that will help make things a bit brighter.</i>\" she says with a bright proud grin on her face as she helps you walk, just to make sure you're alright.");
			outputText("\n\nJust as you're about to leave for your camp you suddenly find yourself wrapped in a warm soft embrace, the heavy pregnant bulge of Minerva's belly pressed against your back. \"<i>I love you, be safe alright, I want my daughters to have their father around when they grow up and I want my mate to give me lots more of those adorable daughters.</i>\" she says before turning you around and pulling you into a deep tongue tangling kiss for a long drawn out moment before the siren reluctantly pulls away from you, a blush on her cheeks. \"<i>Come back soon alright, it will be time to meet both of these sweethearts soon, and I know they will want to see their daddy that rocked them to sleep so often.</i>\" she finishes with her usual sharky grin before finally letting go of you.");
			outputText("Promising to return as soon as you can you turn and start the trek back to camp, your lusts satisfied and your belly full of food.");
			doNext(camp.returnToCampUseOneHour);
		}
		private function processSleepTime():void {
			while (model.time.hours != 6) {
				kGAMECLASS.timeQ = 1;
				goNext(timeQ, false);
			}
		}
		
		private function pregnancyStage4(repeat:Boolean = false):void {
			clearOutput()
			outputText("Once again you find yourself looking at Minerva's gravid belly. It shouldn't take much longer until she gives birth. You put your hand on her belly.");
			if (!repeat) {
				outputText("\n\n\"<i>I'm excited to be a mother. Thank you for helping me and before you know it, soon, I'll have children! We'll make a great family,</i>\" Minerva says.");
			}
			else {
				outputText("\n\n\"<i>I'm excited to have a new addition to our family. Thank you for helping me and before you know it, I'll have more children,</i>\" Minerva says.");
				
			}
			outputText("\n\You tell her that you'll be looking forward to see the new daughters soon. You give her a kiss before you leave the tower to make your way back to camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		//If you're impregnated by Minerva.
		public function pregnancyPlayerStage1(repeat:Boolean = false):void {
			clearOutput();
			outputText("Sliding your hands down over the gentle baby bump swelling your waistline, you cast your gaze to the one that blessed you with such a motherly gift. The proud siren catching your gaze blushes before grinning to you, her own eyes looking you up and down, undressing you as she looks at you with more than a little hunger. She can't help but watch you as you stroke your swollen tummy, tenderly rubbing the baby sirens that you have growing inside your womb. Shifting from side to side, Minerva seems to be trying hard NOT to just pounce you and cuddle your pregnant body. Biting her lip and grinning wider than ever, Minerva can't hold back a moment longer. Letting out a great bird like chirp she cries out, flapping her great wings, the excited herm barrels into you, plowing you over as she wraps her arms around you and squeezes the daylights out of you. \"<i>Oh darling! I can hardly believe it! Pregnant, you're pregnant and its mine...</i>\" she says, ending in a quiet voice. The golden herm sliding her hands over your body, feeling your tummy gently, stroking and caressing you. The siren that impregnated you seemingly, entranced by your pregnant body, her face bright, happier then you have ever seen her. ");

			outputText("\n\n\"<i>So beautiful... You're so beautiful. Oh, [name]! I... I'm so happy, we are going to have a family. I'm going to have a family...<\i>\" she says softly as she holds you. Minerva cradles you against her body, unwilling to get go. Seeing as she is too wrapped up in her affection for you and her soon to be daughters, you let out a chuckle and slip your arms around her, returning her embrace. Pulling you tightly against her body, Minerva slips your head down, letting you rest it on her soft bountiful cleavage. ");

			outputText("\n\nFalling onto her back, Minerva takes you with her, laying with you as she holds you tightly, her hands stroking you tenderly. \"<i>My one and only, my special prime-mate, we are going to have a big beautiful family together. I'll give you all the beautiful, sweet little girls you want, I'll never say no to you lover.</i>\" She says with a great grin on her face before leaning up and kissing you tenderly on the lips. The two of you just lay there for a while, holding each other, kissing and stroking each other. Minerva's hands slowly stroking your belly from time to time.");

			outputText("\n\nGiving you one final kiss on the lips before finally disentangling herself from you and helping you up, her face brightened by her blush, that grin on her face seemingly unable to be removed. \"<i>Thank you for spending this time with me my love, spending that time with you was very important to me, even now words fail me, I can't tell you happy I am.</i>\" she strokes your cheek softly, holding you there for a moment. \"<i>I know you have to go, back to your important champion duties I know, but... just make sure you come back soon, I wouldn't want to miss the birth of our baby, or babies by the looks of it.<\i>\" she says with a very happy tone, clearly overjoyed at the idea of having more than one growing inside you. Giving you one final long tongue filled kiss she lets you go so that you can head back to your camp, but not before giving your [ass] a firm, playful spank.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function pregnancyPlayerStage2(repeat:Boolean = false):void {
			clearOutput();
			outputText("Sliding your hands down over the gentle baby bump swelling your waistline, you cast your gaze to the one that blessed you with such a motherly gift. The proud siren catching your gaze blushes before grinning to you, her own eyes looking you up and down, undressing you as she looks at you with more than a little hunger. She can't help but watch you as you stroke your swollen tummy, tenderly rubbing the baby sirens that you have growing inside your womb. Shifting from side to side, Minerva seems to be trying hard NOT to just pounce you and cuddle your pregnant body. Biting her lip and grinning wider than ever, Minerva can't hold back a moment longer. Letting out a great bird like chirp she cries out, flapping her great wings, the excited herm barrels into you, plowing you over as she wraps her arms around you and squeezes the daylights out of you. \"<i>Oh darling! I can hardly believe it! Pregnant, you're pregnant and its mine...</i>\" she says, ending in a quiet voice. The golden herm sliding her hands over your body, feeling your tummy gently, stroking and caressing you. The siren that impregnated you seemingly, entranced by your pregnant body, her face bright, happier then you have ever seen her. ");

			outputText("\n\n\"<i>So beautiful... You're so beautiful. Oh, [name]! I... I'm so happy, we are going to have a family. I'm going to have a family...<\i>\" she says softly as she holds you. Minerva cradles you against her body, unwilling to get go. Seeing as she is too wrapped up in her affection for you and her soon to be daughters, you let out a chuckle and slip your arms around her, returning her embrace. Pulling you tightly against her body, Minerva slips your head down, letting you rest it on her soft bountiful cleavage. ");

			outputText("\n\nFalling onto her back, Minerva takes you with her, laying with you as she holds you tightly, her hands stroking you tenderly. \"<i>My one and only, my special prime-mate, we are going to have a big beautiful family together. I'll give you all the beautiful, sweet little girls you want, I'll never say no to you lover.</i>\" She says with a great grin on her face before leaning up and kissing you tenderly on the lips. The two of you just lay there for a while, holding each other, kissing and stroking each other. Minerva's hands slowly stroking your belly from time to time.");

			outputText("\n\nGiving you one final kiss on the lips before finally disentangling herself from you and helping you up, her face brightened by her blush, that grin on her face seemingly unable to be removed. \"<i>Thank you for spending this time with me my love, spending that time with you was very important to me, even now words fail me, I can't tell you happy I am.</i>\" she strokes your cheek softly, holding you there for a moment. \"<i>I know you have to go, back to your important champion duties I know, but... just make sure you come back soon, I wouldn't want to miss the birth of our baby, or babies by the looks of it.<\i>\" she says with a very happy tone, clearly overjoyed at the idea of having more than one growing inside you. Giving you one final long tongue filled kiss she lets you go so that you can head back to your camp, but not before giving your [ass] a firm, playful spank.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		//BIRTHING SCENE! FINALLY!
		public function minervaGivesBirth():void {
			if (prison.inPrison) {
				kGAMECLASS.highMountains.minervaScene.pregnancy.knockUpForce();
				flags[kFLAGS.MINERVA_CHILDREN] += 2;
				prison.prisonLetter.letterFromMinerva();
				return;
			}
			clearOutput();
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			kGAMECLASS.highMountains.minervaScene.pregnancy.knockUpForce(); //Clear pregnancy.
			if (model.time.hours < 6) outputText("You're suddenly disturbed by a sound. When you wake up, you see nothing suspicious except for a note on your bed. You open the note and read it. You realize it's from Minerva and she's telling you to come to her! She's going to give birth! You look up at the sky to see it's still night but you grab and light a lantern. You set foot on the path to the high mountains and climb up until you enter the tower where she resides.");
			else outputText("You're wandering your camp until you see a piece of paper with something written on it. You walk over to the note to pick it up and read it. You realize it's from Minerva and she's telling you to come to her! She's going to give birth! You set foot on the path to the high mountains and climb up until you enter the tower where she resides.");
			outputText("\n\n\"<i>It's time! Don't worry, I'm a natural at childbirth,</i>\" Minerva announces. She straddles over to the birthing spot");
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) outputText(" under the giant oak tree");
			outputText(". You remove her short shorts, exposing her genitalia completely. She looks relaxed right now.");
			outputText("\n\nSeveral minutes passes and there's no sign of change. Without warning, the water breaks and liquid gushes out from Minerva's womb! \"<i>I'm going to deliver now,</i>\" Minerva says. You watch as a head emerges from her womb and soon, the rest of a little siren. Another siren soon slips out of Minerva's womb. You watch as Minerva's belly deflates to normal and smile.");
			outputText("\n\n\"<i>They're so beautiful. Our two little sirens,</i>\" she says. ");
			if (flags[kFLAGS.MINERVA_CHILDREN] <= 0) outputText("\"<i>I feel like a mother again and I want to thank you for helping me. You've fulfilled my wishes,</i>\" she says gratefully with a smile. ");
			outputText("You lay down next to her and relax, even taking the time to examine the young sirens. They have the same hair color, possess a pair of wings, and are both hermaphrodites. They look so adorable! ");
			outputText("No wonder they will eventually grow up to be virile and fertile to help expand the sirenic population.");
			flags[kFLAGS.MINERVA_CHILDREN] += 2;
			if (model.time.hours < 6) {
				outputText("\n\n\"<i>You can sleep with me if you like to. After all, it's still night,</i>\" she says. You nod and cuddle next to her.");
				doNext(sleepWithMinervaPostBirthing);
			}
			else {
				outputText("\n\nThe newborn sirens begin to latch onto Minerva's breasts and suckle milk. \"<i>They're great. They'll grow up nicely,</i>\" she says. You give her a kiss on the cheek and let her know that you're going back to your camp. You wave her goodbye and you make your way back to camp.");
				doNext(camp.returnToCampUseOneHour);
			}
		}
		
		//Player gives birth!
		public function playerGivesBirth():void {
			kGAMECLASS.highMountains.minervaScene.minervaSprite();
			outputText("A pain develops in your abdomen. You realize it's time to give birth to the sirens! You set foot on the high mountains path and hurry to the tower.");
			outputText("\n\n\"<i>It's coming!</i>\" you announce. Minerva rushes to you to get you to the birthing spot");
			if (flags[kFLAGS.MINERVA_TOWER_TREE] > 0) outputText(" under the giant oak tree");
			outputText(". \n\n\"<i>You'll be okay. Just take a deep breath,</i>\" she instructs. You do as she requested, taking deep breaths. She slowly removes the bottom half of your " + player.armorName +" so that your groin is exposed. ");
			if (player.hasCock()) {
				outputText("She lifts your cock ");
				if (player.balls > 0) outputText("and balls ");
				outputText("to reveal your " + player.vaginaDescript() + ".");
			}
			outputText("\n\nYou wait. Time goes by and you talk about various topics with her. Finally, the water breaks. She gasps. \"<i>Just push. I'll catch whatever's coming out,</i>\" she assures. ");
			outputText("\n\nYou push as hard as you can, remembering to take deep breath between pushings. The head of a siren crowns. \"<i>You're doing great! You'll be giving birth to two daughters,</i>\" she says, encouraging you to push again. You keep pushing until finally, the baby becomes loose enough. Minerva picks up the baby. \"<i>Just one more,</i>\" she says.");
			player.cuntChange(40, true, false, true);
			outputText("\n\nYou struggle to push the last of the sirens out. Eventually, you manage to push the last out. \"<i>Great! You just gave birth to two beautiful sirens. I couldn't be more happier,</i>\" she says excitedly.");
			outputText("\n\n\"<i>Just rest. I'll take care of them");
			if (flags[kFLAGS.MINERVA_CHILDREN] > 0) outputText(". My daughters are already excited to see their new addition to our family");
			outputText(",</i>\" she says. You spend some time resting while she breastfeeds her newborn sirens.");
			outputText("\n\nEventually, you get up and give her a kiss. \"<i>Come back later. Our daughters are already excited to see you come back,</i>\" she says. You acknowledge and head back to your camp.");
			flags[kFLAGS.MINERVA_CHILDREN] += 2;
			flags[kFLAGS.TIMES_BIRTHED_SHARPIES]++;
			doNext(camp.returnToCampUseOneHour);
		}
		

	}

}
