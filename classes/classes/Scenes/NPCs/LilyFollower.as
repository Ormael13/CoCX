/**
 * ...
 * @author Canadian Snas
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Items.UndergarmentLib;
import classes.Scenes.Camp;
import classes.Scenes.SceneLib;
import classes.Scenes.NPCs.Lily;
import classes.internals.SaveableState;
import classes.display.SpriteDb;
	
	use namespace CoC;
	
	public class LilyFollower extends NPCAwareContent implements SaveableState {
		public static var LilyHairColor:String;
		public static var LilySkinTone:String;
		public static var LilyAffectionMeter:int;
		public static var LilySubmissivenessMeter:int;
		public static var LilyTalked:Number;
		public static var LilyFollowerState:Boolean;
		public static var LilyExhibitionAble:Boolean;
		public static var Lily3SomeSidonie:Boolean;
		public static var Lily3SomeIzma:Boolean;

		public function stateObjectName():String {
			return "LilyFollower";
		}

		public function resetState():void {
			LilyHairColor = "";
			LilySkinTone = "";
			LilyAffectionMeter = 0;
			LilySubmissivenessMeter = 0;
			LilyTalked = 0;
			LilyFollowerState = false;
			LilyExhibitionAble = false;
			Lily3SomeSidonie = false;
			Lily3SomeIzma = false;
		}

		public function saveToObject():Object {
			return {
				"LilyHairColor": LilyHairColor,
				"LilySkinTone": LilySkinTone,
				"LilyAffectionMeter": LilyAffectionMeter,
				"LilySubmissivenessMeter": LilySubmissivenessMeter,
				"LilyTalked": LilyTalked,
				"LilyFollowerState": LilyFollowerState,
				"LilyExhibitionAble": LilyExhibitionAble,
				"Lily3SomeSidonie": Lily3SomeSidonie,
				"Lily3SomeIzma": Lily3SomeIzma

			};
		}

		public function loadFromObject(o:Object, ignoreErrors:Boolean):void {
			if (o) {
				LilyHairColor = o["LilyHairColor"];
				LilySkinTone = o["LilySkinTone"];
				LilyAffectionMeter = o ["LilyAffectionMeter"];
				LilySubmissivenessMeter = o["LilySubmissivenessMeter"];
				LilyTalked = o ["LilyTalked"];
				LilyFollowerState = o["LilyFollowerState"];
				LilyExhibitionAble = o ["LilyExhibitionAble"];
				Lily3SomeSidonie = o ["Lily3SomeSidonie"];
				Lily3SomeIzma = o ["Lily3SomeIzma"];
			} else {
				// loading from old save
				resetState();
			}
		}

		public function LilyFollower() {
			Saves.registerSaveableState(this);
		}

		public function lilyAffection(changes:Number = 0):Number {
			LilyAffectionMeter += changes;
			if (LilyAffectionMeter > 100) LilyAffectionMeter = 100;
			else if (LilyAffectionMeter < 0) LilyAffectionMeter = 0;
			return LilyAffectionMeter;
		}

		public function lilySubmissiveness(changes:Number = 0):Number {
			LilySubmissivenessMeter += changes;
			if (LilySubmissivenessMeter > 100) LilySubmissivenessMeter = 100;
			else if (LilySubmissivenessMeter < 0) LilySubmissivenessMeter = 0;
			return LilySubmissivenessMeter;
		}

		public function lilyEncounter():void {
			spriteSelect(SpriteDb.s_drider);
			clearOutput();
			if (flags[kFLAGS.LILY_LVL_UP] == 1) {
				outputText("Bushwhacking your way through the dense foliage of the swamp, it soon becomes clear that you've wandered into spider territory.  Webbing hangs from trees and the dark, dank air hides ambushes well.  Diligence and wariness pay off, for you become aware of a skittering too near to be simple background noise.\n\n");
				outputText("As far as you're aware, it's unlikely you'll be able to scare your stalker off, and so you simply wait for them to show themselves.  You search with your eyes and, noisily clearing your throat, make it clear you're aware of their presence.  Soft chuckling chimes around you, seeming to originate from several places in the scrub, but nothing appears.  You turn about and call again, raising your [weapon].  A gentle tap on the shoulder answers you, but when you look the vista is equally as desolate as the first time.  And where the hell is that laughing coming from?\n\n");
				outputText("Spinning again, you lose your patience and loudly demand your ambusher present itself.  A soft tug on your ");
				if (player.tailType > Tail.NONE) outputText("tail ");
				else outputText("hair ");
				outputText("pulls you back halfway, but as you open your mouth to yell, the ground gives a quiet thump.  Just barely in your periphery, you see a white apparition with a yawning mouth stretching out to bite, and your reflexes take over, dropping your weight and rolling you away from it.\n\n");
				outputText("\"<i>Clever little pet,</i>\" the phantom spits, resolving into the shape of a drider as your eyes focus and your adrenaline haze clears.  Raising a cupped hand to her ghoulishly grinning mouth, she laughs into it; a minute shivering in the air reveals the taut threads of silk attached to her finger.  The vibrations travel down them, shaking several silk-tied leaves and producing the raspy, laughing audience from before.  \"<i>It'd be so much easier on you if you'd just walked into the trap, sweetness.</i>\"\n\n");
				outputText("You've yet to meet a wild drider that let you walk away without some sadistic display of power, and Lily looks to be no different.");
			}
			else {
				LilyHairColor = randomChoice("red", "orange", "green");
				LilySkinTone = randomChoice("yellow", "purple", "red", "turquoise");
				outputText("While you explore the swamp, the sun's light withers and fades.  You look up through the mossy trees, but the sky is totally blocked from sight.  It's nearly as purple as twilight here, but you press on, brushing aside old spider-webs as you go.  Faintly, you can hear the sound of skittering legs moving around you, but with the way the damp air muffles everything, it's impossible to tell from which direction.\n\n");
				outputText("You catch a blur of movement to the side, but by the time you turn for a better look, it's gone.  How odd.  Turning your eyes back to your path, you're shocked to see the form of a massive spider-woman in front of you.  She isn't just some humanoid spider-morph - she's a full-fledged drider, with a giant spider's body from the waist down and eight spindly legs supporting her.  Her eyes practically glow bright " + LilySkinTone + " while her venom-soaked lips twist into a cruel, confident smile.\n\n");
				outputText("\"<i>I found you " + player.mf("master", "mistress") + ", I'm so happy!</i>\" croons the drider.\n\n");
				outputText("Her tone makes it quite clear you'll have to run or fight your way out of this!");
				flags[kFLAGS.LILY_LVL_UP] = 1;
			}
			startCombat(new Lily());
			//doNext(playerMenu);
		}
		
		public function LilyAfterBattle():void {
			clearOutput();
			if (LilySubmissivenessMeter<=20) outputText("The Drider Woman falls onto her side, baring her teeth at you. <i>\"I...Won’t…\"</i> She draws her bow back, aiming with shaking hands, but the arrow flies past. <i>\"Damn you\"</i>. She watches, anger in her gaze, as you approach. <i>\"Well...What do you want?\"</i>\n\n"); 
			else if (LilySubmissivenessMeter <= 40) outputText("She aims an arrow at you, weak and trembling, but as the Drider fires, you notice that the arrow misses wider than you thought it would. You turn back towards her, a little smile on your face, and although her eyes are angry, the high blush in her cheeks and her rapidly moistening pussy betray her lust. Apparently this spider-skank has a submissive side to her!\n\n"); 	
			else if (LilySubmissivenessMeter <= 60) outputText("Lily falls onto her side, her Silk Panties choosing that moment to slip, revealing her pierced labia and rock hard clit. She fires an arrow at you, but it’s slow enough that you easily catch it. Unlike her other arrows, this one has a heart-shaped tip, and just bringing it near your face brings a blush to your cheeks. Was that her idea of seduction, or tempting you?\" She glares at you, her legs shaking, but the six eyes seem to be glaring just a little too hard. Considering her drenched pussy, the fact she hasn’t covered up yet, and the blush in her cheeks, Lily seems more excited than scared.\n\n"); 	
			else if (LilySubmissivenessMeter <= 80) outputText("The Drider woman curses, her abdomen clenching as she falls over. <i>\"No, not-\"</i> Her voice is cut off as her spinnerets let loose a veritable deluge of sticky threads. She tries to block them...with her hands…? Binding them together. She charges towards you, hands bound, but trips and falls around twenty feet away. She doesn’t even try and pretend anymore, looking up at you expectantly and smooshing her breasts together. A thin trail of lubricants trickles downhill from her pelvic region.\n\n"); 	
			else outputText("Lily doesn’t even pretend to be angry, diddling her twat with one hand and pulling at her chain with the other. <i>\"[name], please. Stop with the violence\"</i>, she calls out. <i>\"We both know I don’t want to hurt you\".</i> She binds her own hands behind her back expertly with swift spurts of webbing, then wiggles her body, showing her pussy shamelessly. <i>\"See how wet I am?\"</i>\n\n"); 	
			menu();
			addButton(0, "Leave", cleanupAfterCombat);
			addButton(1, "Talk", LilyTalk);
			if (LilyAffectionMeter >= 20) {
				if (player.lust >= 33) {
					if (player.gender > 0) addButton(2, "Sex", LilySex);
					else addButtonDisabled(2, "Sex", "Not for genderless.");
				}
				else addButtonDisabled(2, "Sex", "Your lust is too low.");
			}
			else addButtonDisabled(2, "Sex", "Req. 20%+ affection.");
			if (player.lust >= 33) {
				if (player.gender > 0) addButton(3, "Rape", LilyRape);
				else addButtonDisabled(3, "Rape", "Not for genderless.");
			}
			else addButtonDisabled(3, "Rape", "Your lust is too low.");
			if (LilySubmissivenessMeter >= 80) addButton(5, "DomHome", LilySubComeCamp);
			else addButtonDisabled(5, "???", "Req. 80%+ submissiveness.");
			if (LilyAffectionMeter >= 50) addButton(6, "Come2Camp", LilyBringCamp);
			else addButtonDisabled(6, "???", "Req. 50%+ affection.");
		}

		public function LilyTalk():void {
			clearOutput();
			if (LilyTalked > 0) outputText("She stands, looking almost disappointed. \"<i>Oh, is that all you wanted? Then why…? She shakes her head. “Very well, what is it?</i>\"");
			else {
				outputText("You tell the downed Drider lady that you got off on the wrong foot. You tell her your name, and that you didn’t want to hurt her. You ask her name, and she rolls her eyes, standing back up. \"<i>I am called Lily. This area of the woods is dangerous, [race].</i>\" She looks at you strangely, getting up. \"<i>Look, [name], I don’t want to waste time. What’s on your mind?</i>\"");
				LilyTalked = 1;
			}
			menu();
			if (LilyFollowerState) addButton(0, "Back", LilyCampBack);
			else addButton(0, "Leave", cleanupAfterCombat);
			addButton(1, "Herself", LilyTalkHerself);
			if (LilyTalked > 1) addButton(2, "Driders", LilyTalkDriders);
			else addButtonDisabled(2, "Driders", "Req. to talk about 'Herself' first.");
			if (LilyTalked > 2) addButton(3, "D.Society", LilyTalkDriderSociety);
			else addButtonDisabled(3, "D.Society", "Req. to talk about 'Driders' first.");
			if (LilyAffectionMeter >= 20) {
				addButton(5, "D.MatingRituals", LilyTalkDriderMatingRituals);
				addButton(6, "DriderPods", LilyTalkDriderPods);
			}
			else {
				addButtonDisabled(5, "???", "Req. 20%+ affection.");
				addButtonDisabled(6, "???", "Req. 20%+ affection.");
			}
		}
		public function LilyTalkHerself():void {
			clearOutput();
			outputText("\"<i>...I’m a huntress. I kill things so I can eat things. I have urges, I deal with them when they arise.</i>\" She shakes her head. \"<i>What else is there to say?</i>\" She turns around. \"<i>I am leaving now.</i>\" She skitters off into the woods, and you head back to camp.");
			if (LilyTalked == 1) {
				lilyAffection(5);
				LilyTalked = 2;
			}
			if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		public function LilyTalkDriders():void {
			clearOutput();
			outputText("\"<i>Oh my, someone who doesn’t just want a dick in every hole? Refreshing.</i>\" She folds her spider legs. \"<i>Well...Under normal circumstances, we’re organized into small village-groups. We hatch in pods, similar to other spiders, and are generally not dissimilar to other races of Mareth.</i>\" You raise an eyebrow, dubious, and she waves it off.\n\n");
			outputText("\"<i>Under normal circumstances. [name]. Clearly a world where you’re under constant threat of physical and sexual invasion isn’t...normal.</i>\" She tugs on her chain, making her quad breasts bounce a little. Your gaze is drawn to them, and she smiles slightly. \"<i>Well, if that’s all you wanted, then I can leave now, yes?</i>\" She turns her back to you, rushing off into the trees.");
			if (LilyTalked == 2) {
				lilyAffection(5);
				LilyTalked = 3;
			}
			if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		public function LilyTalkDriderSociety():void {
			clearOutput();
			outputText("\"<i>Well, most races of Mareth developed farming practices, larger towns and even cities. We Driders never really went there, preferring to remain fairly scattered, either in our own little colonies, or at the fringes of theirs. Because of our...natural gifts,</i>\" she tugs on her chain, but you know she means their venom and silk. ");
			outputText("\"<i>Our services were always in fairly high demand. Silk clothing, underwear and robes were always popular, and Drider venom has medicinal purposes, when processed by an alchemist that knows what they’re doing.</i>\" She smiles at you, apparently liking the opportunity to talk about her race. ");
			outputText("\"<i>My people, as a result, put an emphasis on craftsmanship, weaving and alchemy, when hunting wasn’t the most lucrative.</i>\" She bobs a little. \"<i>Some larger tribes even established their own unique patterns and magics, passing them down to the most skilled...weaver of their…</i>\" Her violet eyes widen, and she turns away.\n\n");
			outputText("\"<i>I think that’s enough learning for today. I need to find...food. Yes, food.</i>\" You know she’s lying, but before you can say anything, she’s run into the trees.");
			if (LilyTalked == 3) {
				lilyAffection(5);
				LilyTalked = 4;
			}
			if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		public function LilyTalkDriderMatingRituals():void {
			clearOutput();
			outputText("At your question, she blinks. \"<i>I’m sorry, what did you ask? I’m not sure I heard that right.</i>\" You repeat your question, and she blushes, turning her head away from you. \"<i>W-well...I see no harm in giving you that information.</i>\" She clears her throat, turning back.\n\n");
			outputText("\"<i>Well...We Driders don’t typically mate for life, like most races of Mareth did...Well...Before the demons. Typically, mating pairs or groups are formed based on agreements, or later on, when a decent town is founded, based on increasing the offspring’s potential. This could lead to one female having multiple partners, if her egg-laying is up to speed, or vice-versa, to spread a particularly skilled or strong male’s…</i>\"\n\n");
			outputText("She blushes, looking away. \"<i>Skills...Around. Of course, like any other race, plenty of us disregarded those rules if there was someone who really caught our eye.</i>\" She leans forward, then realizes what she’s done. \"<i>B-But that’s fairly rare!</i>\"\n\n");
			lilyAffection(5);
			if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		public function LilyTalkDriderPods():void {
			clearOutput();
			outputText("You ask Lily what she means by ‘pod mates’. You tell her that you understand that it’s the Drider equivalent of siblings, but you want her to go into more detail.\n\n");
			outputText("\"<i>Ah, yes. I suppose you being human "+((player.humanScore() < player.humanMaxScore() - 9) ? "once ":"")+"would leave you a little confused on the matter.”</i> Lily crosses her arms in front of her top pair of breasts. <i>“Well, to be precise, Driders lay eggs, rather than live birth like those who have more mammalian roots. those born in different clutches, but to the same parents, rarely have the same sense of “family” as those born in the same clutch of eggs.</i>\" ");
			outputText("She rolls a hand. \"<i>Otherwise, most Driders would share familial feelings with half the village, being half-siblings, or whatnot.</i>\"\n\n");
			outputText("This makes sense to you, and you thank your kinky drider for clarifying.\n\n");
			outputText("\"<i>Oh, it’s no problem.</i>\" She gives you a little smirk. \"<i>Besides, there’s only a few reasons you’d be asking about such a topic, after all.</i>\" She gives you a knowing smile, running her finger from her hip down to her moist muff. She catches you looking, and her smile grows, showing her fangs. \"<i>Interested in making some, I assume?</i>\"\n\n");
			lilyAffection(5);
			if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilySubComeCamp():void {
			clearOutput();
			outputText("You order your pet to bind herself. She does so, with gusto, and you grin, taking more silk from her spinnerets and wrapping them around your toy’s head. You attach a rope to her nipple-chain, and pull, like you would a dog’s leash. You tell your spider-toy that you’re going for a long walk, and that she’s forbidden from pleasing herself until you get to where you’re going. You ignore her moans of protest, and start walking.\n\n");
			outputText("A trail of lubricant follows Lily’s pussy, and you tsk, turning around and inspecting her. You haven’t traveled long, but she’s already sopping wet. You tweak her little clitty, getting a moan, and keep walking. Every time she stops, you pull on her leash, getting another muffled moan from the debilitatingly aroused Drider. Every so often, she slips a hand down to her muff, forcing you to stop, punish her, and continue.\n\n");
			outputText("You run into several imps along the way, but they think better of messing with you and a Drider. As Lily tries to rub her slit, you slap her hand away, telling her that if she does that again, you’ll call the imps over and let them have their way with her. At that, Lily tries to pull away, but you yank on her chain again.\n\n");
			outputText("<i>\"...You won’t do that\",</i> she whispers. <i>\"You wouldn’t want my eggs to be fertilized by anyone but you\".</i> You think for a moment, and reluctantly agree.\n\n");
			menu();
			addButton(1, "BringIn", LilyEnterCamp);
			if (TyrantiaFollower.TyrantiaFollowerStage >= 4) {
				if (player.gender == 0) addButtonDisabled(3, "Tyrantia", "Not for genderless ones.");
				else addButton(3, "Tyrantia", LilyTyrantia3some1st);
			}
		}
		
		public function LilyTyrantia3some1st():void {
			clearOutput();
			outputText("Struck by a fun idea, you decide to leave your Drider-toy tied up to a tree outside camp. You tell your toy that you’ll be back soon, and that she’d better be ready for a fucking.\n\n");
			outputText("<i>\"Ohh, yes!\"</i> Lily’s drooling steadily, from both her mouth and cunt, her chitin-covered front legs shaking with anticipation. <i>\"Hurry, " + player.mf("master", "mistress") + "!\"</i>\n\n");
			outputText("<i>\"What kind of fun, lover?\"</i> You tell Tyrantia that you’ve got someone new you’re bringing into camp, a Drider like her, but a raging submissive. You give Tyrantia a grin, asking her if she’d like to help you break in the new toy. She looks a little wary, but you put a hand on the giantess’s leg, assuring her it’s consensual.\n\n");
			outputText("Tyrantia brightens up, and grabs her Dick, where it’s propped up on the wall. <i>\"Okay, so what’s the new girl’s name, [name]?\"</i>\n\n");
			outputText("You tell your Drider lover that her name’s Lily. Tyrantia’s eyes glow brighter, and she glares at you. <i>\"If you’re lying to me, I’m going to rip an arm off you, lover. Don’t joke about family\".</i> She looms over you, and then smiles, breaking the tension. <i>\"That being said...You think it’s her?\"</i> You describe Lily, her books, and her bow, and Tyrantia’s eyes widen in amazement. You take your giantess’s hand, leading her to where you left Lily tied up.\n\n");
			outputText("<i>\"...Oh, we are gonna have some fun.\"</i> Tyrantia whispers to you.\n\n");
			outputText("You take the lead, walking from behind and running your hand along her Drider-half. You tweak her spinnerets, tickling each of her legs on that side as you sensually walk to her front. Clear fluid runs down her front legs, and you take each one in your hands, inspecting them. You tell her that she’s been a naughty girl. She came while you were gone, didn’t she?\n\n");
			outputText("<i>\"N-no, I d-didn’t!\"</i> She protests, and you make a slapping motion, for Tyrantia’s benefit. She grins, stalking up behind Lily and waiting for your command. Despite her submissive state, Lily proves her huntress’s ears are still there, trying to turn from you. <i>\"I-is there someone there?\"</i> You grab Lily’s chain, pulling her womanly half back towards you and making her wail as the sensitive nipples are yanked.\n\n");
			outputText("You tell Lily that there’s nothing for her to be worried about...As long as she behaves. You nod to Tyrantia, and the woman slaps the side of her Dick against Lily’s spinnerets. Lily gasps, pulling away, but you yank again. Lily whimpers as you tell her that you couldn’t trust her. She protests, but you bring up the imps, all the times she stopped to pleasure herself...You tell her that all you wanted was to bring your favorite little pet home...But now you have to make sure she’s still who you thought she was.\n\n");
			outputText("Lily subsides, spreading her legs wide and letting you see every fold of her well-fucked pussy. <i>\"I’m sorry, " + player.mf("master", "mistress") + ". Please forgive your...pet.\"</i>\n\n");
			menu();
			if (player.hasCock()) addButton(1, "Fuck", LilyTyrantia3Fuck);
			if (player.hasVagina()) addButton(2, "LickYou", LilyTyrantia3Lick);
		}
		
		public function LilyTyrantia3some():void {
			clearOutput();
			outputText("You leave Lily tied up at a small tree, not far from camp, and come back in, getting your giantess lover’s attention. You ask her if she’d like to have some family bonding time with you and her little sister. Tyrantia grabs her Dick, giving you a thumbs up. She follows you out to the tree, whistling in appreciation at the sight of her little sister, bound, gagged and blindfolded.\n\n");
			outputText("<i>“So…How do you want to play this out, lover?”</i> Tyrantia whispers, dropping a hand to her slick, black quim. You gaze at the giantess thoughtfully.\n\n");
			menu();
			if (player.hasCock()) addButton(1, "Fuck", LilyTyrantia3Fuck);
			if (player.hasVagina()) addButton(2, "LickYou", LilyTyrantia3Lick);
		}
		
		public function LilyTyrantia3Fuck():void {
			outputText("You undress slowly, then step in. Practically whining with need, Lily’s bound hands quiver as she tries to bring them to her soaking quim. You take your time, then as she struggles with her bindings, you bring your hand to her slit, rubbing the length of her womanhood with one finger. Lily shivers, chitin-covered knees quivering.\n\n");
			outputText("She bites down on a moan of arousal as you bring a second finger in, sinking your fingers in, just to the first knuckle. She quivers as you begin fingering her, slowly teasing Lily with your hands. She tries to hold herself back, but Lily begins panting, quad breasts shaking as you slowly pick up the pace, sinking your fingers deeper, flicking her clit with your tongue.\n\n");
			outputText("<i>\"Ah-Ahn!\"</i> A thin trickle of moisture hits your fingers, slimy femcum clear on your digits. You give her a sigh. Clearly your pet needs some punishment. Without warning, you grab her shoulders, spreading her femcum all over one, then bring your hips in, sinking your [cock] to the hilt into Lily’s still spasming pussy.\n\n");
			outputText("<i>\"F-F-Fuck…!\"</i> Lily’s upper body shivers, and she leans on you, her soft breasts smooshing against your [chest]. Not giving her a second to rest, you begin pounding her sensitive pussy. You quickly build up to a vicious speed, Lily nearly insensate from the rough treatment, her arms draping over your shoulders. Her breath comes fast and short, and she clamps down, her slick fuck-hole clinging to your [cock].\n\n");
			outputText("<i>\"[master], p-please…!\"</i> Lily tries to speak, but you shut her up with a kiss, grabbing her chain and pulling roughly as you french her, her tongue hanging out and into your mouth. With another slam of your [hips], you pull your mouth back, telling Lily that you can’t hear her. She tries to speak, but you french her again, shutting her up. Grinning, you tell your slut to speak up as she clamps down hard on your shaft, spraying your [legs] with her love juice.\n\n");
			outputText("<i>\"Ahhhn! I-I-I…c-can’t…!\"</i> Lily squeals as you rub her clit, shaking like a leaf against you. She’s bucking her own hips in time with you, her second orgasm wracking her more than the first. <i>\"P-p-please…I can’t t-t-take much m-m-more!\"</i>\n\n");
			outputText("Tyrantia, now openly jilling herself off, snaps to attention as you catch her eye. You grin, motioning to her Dick, and slap Lily’s palmable asscheek. You can feel your [cock] starting to twitch, but you’re not ready to come just yet. Still fucking Lily, you grab her asscheeks with both hands, gleefully telling her to open wide. Completely misunderstanding you, Lily sticks her tongue out, eyes wide as if for a facial. However, you grab her tighter, spreading her cheeks wide as Tyrantia slides her Dick between her sister’s asscheeks.\n\n");
			outputText("Lily gasps as Tyrantia pulls back on her hair, bending Lily back as she brings her lips down for a kiss, smothering her smaller sister. You feel Lily tighten, wailing through Tyrantia’s lips as the giantess slides her dick deep into Lily’s asshole.\n\n");
			outputText("You and Tyrantia slow down the pace a little, mainly because you can feel your shaft twitching, begging for release. While you hold off your own orgasm, gritting your teeth as your shaft slides through Lily’s love-hole, you notice Tyrantia unbinding Lily’s shaking arms, guiding her sister’s fingers to her own sopping wet hole. Your giantess hums as Lily begins jilling Tyrantia off.\n\n");
			outputText("Pulling at Lily’s chain, you run your teeth on her neck, and as you let out a groan, your [cock] finally spilling over, Lily wails for a third time, her walls clamping down on you hard. Finally, this sends you over the edge, and you slam your [cock] in as far as it’ll go, spurting your load into her innermost depths. As you fill her, your cum leaking out from her tight fuckhole, Tyrantia groans, a smile on her face as she wipes her love juices off on Lily’s chitinous backside. You let Lily fall, and her eyes are closed. Her breathing is ragged, and you give your fucktoy time to recover from her ordeal.\n\n");
			outputText("A full fifteen minutes later, Lily opens one of her eyes, moaning slightly. <i>\"Wow…[name], I…Didn’t expect that. Without a doubt, that was the best I’ve had in…well…A LONG time.\"</i> She seems to realize that there was someone else, and she whirls around, catching sight of Tyrantia. <i>\"Oh, hey sis.\"</i> Tyrantia says, waving her Dick cheekily. <i>\"Fancy meeting you here.\"</i>\n\n");
			player.sexReward("saliva","Dick");
			if (!LilyFollowerState) LilyTyrantiaAfterFirst();
			else LilyTyrantiaAfterSex();
		}
		public function LilyTyrantia3Lick():void {
			outputText("You undress, showing your [pussy] to the world. Tyrantia whistles, giving you a wink...But not to Lily, blind as she is. You slap her shoulders, ordering her to get on the ground. She does so, and you force her human upper body back onto her spider carapace. Satisfied, you climb her, firmly planting your folds onto your Drider-toy’s lips.\n\n");
			outputText("<i>\"Start Licking\"</i> you order, and your toy gets to work, her long, sticky tongue pushing past your labia and into your folds, the muscle rubbing the walls of your pussy. Motioning Tyrantia over, you rest your full weight on Lily’s head, your Drider-toy’s gasps for air all the more delicious. Tyrantia strips, lowering her upper body to your level, and you wrap one hand around tyrantia’s head as you french her, running the tip of your tongue along her fangs. The much-larger Drider leans down, looming over you, her hand dropping to your nub. Tyrantia starts rubbing your [clit], and you return the favor, sticking two fingers into your big lover’s quim and jilling her off.\n\n");
			outputText("The three of you sink into a slow grind, your folds dripping into Lily’s mouth, forcing her to push your leavings aside to breathe. You grind your folds into Lily’s face, wrapping your legs around her as she begins to buck underneath you.\n\n");
			outputText("Your bigger lover pulls her head back. <i>\"Lover, would you mind it if I tended to your toy?\"</i> Tyrantia asks sweetly. <i>\"I think the poor thing’s just about out of energy\".</i> You nod, and Tyrantia pulls out of your embrace, her cunt drooling as your hand leaves. Tyrantia grabs her Dick, slowly, teasingly dragging the tip of it down Lily’s upper body, whacking her jiggly breasts before rubbing it against Lily’s sopping passage. Under you, Lily’s Spider-legs curl, not unlike a dead spider you saw on the windowsill, and she screams into your needy quim as Tyrantia slips her Dick into Lily’s box.\n\n");
			outputText("<i>\"Oh, this little bitch likes it, huh?\"</i> Tyrantia asks, gripping the shaft with both hands. <i>\"Good\"</i>. She sinks her Dick in, nearly a foot at once. Lily sprays Tyrantia’s lower body with her fluids, but this just makes Tyrantia sink it in a little more, twisting before she pulls back and out. Without the Dick inside her, Lily’s legs spasm, and she nearly falls over.\n\n");
			outputText("<i>\"Oh, oh my.\"</i> Lily breathes heavily, her face covered in your femcum. You climb off of your well-fucked toy, and she gasps for air.\n\n");
			player.sexReward("saliva","Pussy");
			if (!LilyFollowerState) LilyTyrantiaAfterFirst();
			else LilyTyrantiaAfterSex();
		}
		
		public function LilyTyrantiaAfterFirst():void {
			outputText("<i>\"Wh-who else was there? I...You’re my " + player.mf("master", "mistress") +", but I didn’t...I didn’t...want…Anyone else to-\"</i> She takes the blindfold off, and her mouth flies open as she beholds your giantess lover beside you, licking Lily’s leavings off her Dick.\n\n");
			outputText("<i>\"Oh, hey sis.\"</i> Tyrantia says, swallowing some of her sister’s spunk. <i>\"Fancy meeting you here.\"</i>\n\n");
			outputText("Lily stares, dumbstruck, as Tyrantia grins, looming over her much smaller sister. <i>\"What...how? What the hell? Is that all you could think to say?!\"</i> She blinks. <i>\"And was that your...Dick? Dildo? Spear?!\"</i>\n\n");
			outputText("\"Yeah...This is m’dick.\" She leans down, wrapping her arms around Lily’s shoulders. \"But honestly, I think you’re not really looking at the important stuff here.\" She grins, wiping her arm on Lily’s back half. <i>\"I…never thought I’d see you again.\"</i>\n\n");
			outputText("<i>\"...You’re still not going to let me live this down…are you?\"</i> Lily asks nervously.\n\n");
			outputText("<i>\"Nope!\"</i> Tyrantia grins. <i>\"And you’re not gonna let your big bad sis stop you from pleasing your "+ player.mf("master", "mistress") +", are you?\"</i> Lily shakes her head, and looks at you. She’s still spunk-drunk, but visibly pulling herself back together.\n\n");
			outputText("<i>\"Now we’ve had our fun, can I show her around?\"</i> Tyrantia asks, and you nod. Tyrantia takes her sister by the hand. <i>\"Well, you’ve already sampled the best part, but the rest of this place isn’t bad either.\"</i> The two Driders saunter towards Tyrantia’s section of camp.\n\n");
			doNext(LilyComeCampConclusion);
		}
		
		public function LilyTyrantiaAfterSex():void {
			outputText("Tyrantia unbinds her little sister, who simply stares up at her, tongue out and eyes glazed over. <i>\"Good girl,\"</i> your giantess says simply, patting Lily’s head. The smaller Drider looks over at you, a blissed out look on her face.\n\n"); 
			outputText("<i>\"" + player.mf("master", "mistress") + ", that…was…\"</i> Lily shakes, and you reach to her face, cupping her cheek in your palm. You tell your pet she did well, and Lily smiles, eyes closing as she flops the rest of the way to the ground.\n\n");
			outputText("<i>\"We gotta do this again sometime,\"</i> your giantess says, and you’re inclined to agree. But for now, you redress, heading back to your part of camp.\n\n");
			doNext(camp.returnToCampUseOneHour);
		}

		
		public function LilyEnterCamp():void {
			clearOutput();
			outputText("You bring Lily near your camp, and turn around again to look at your Drider-toy. Her legs are shaking, and her quad tits tremble as she’s working at her blindfold with her elbows. She manages to lever the blindfold off, and she looks at the camp with a somewhat impressed look on her face. <i>\""+ player.mf("master", "mistress") +", is this your camp?\"</i> She asks, and you smile, taking your pet’s face in your hands.\n\n");
			outputText("You tell her that she’s going to stay at your camp from now on, and she’s going to like it. Lily trembles, her lower lips trembling and her six eyes lit up.\n\n");
			outputText("<i>\"Truly "+ player.mf("master", "mistress") +"? You want your toy around?\"</i> Lily shakes her upper body at you, making sure her chain rattles. <i>\"What naughty things are you going to do to me?\"</i> She gives you a rather lascivious smile. <i>\"On second thought...Don’t tell me. Make it a surprise...MMmmm!!\"</i> Lily charges off, setting her sights on a tree near the river. <i>\"I’ll make myself a little nest, and then we’ll...Oh, I am going to love it here!\"</i>\n\n");
			outputText("You give Lily a gentle shove, and she nods, understanding what you mean. She runs towards a tree near the river, not far from camp. You head back into camp, and as you turn back towards Lily’s Tree, you can already see her spinning out threads.\n\n");
			LilyComeCampConclusion();
		}
		
		public function LilyBringCamp():void {
			clearOutput();
			outputText("You ask Lily about her life in the swamp. She shrugs, looking around. <i>\"It’s nice for a Drider like me, although to be honest, the neighbors aren’t exactly ideal\".</i> She looks at you, a pained smile on her face. <i>\"I enjoy a good tussle or lay as much as the next gal, but...Those...Things aren’t even a good fuck. They’re all for tying you up, but they’ve got no finesse...Not to mention the dicks on them. I like a good lay, but they’re...Wrong\".</i> She looks down at herself. <i>\"Not that I can really talk...I became like them, living in the swamp.\"</i>\n\n");
			outputText("You ask if she’d rather have you as a neighbor instead. <i>\"Well, of course, but I…\"</i> She freezes for a second. <i>\"Did you just ask me to come live with you?\"</i> You nod, giving her a smile. <i>\"Seriously?\"</i> She thinks for a moment. <i>\"I’m guessing there are others who live with you\".</i> You nod, and she gives you a serious look. <i>\"...They do not get to know\".</i> You tilt your head, confused, and she blushes, raising her voice. <i>\"I mean about us\".</i> You ask her why that matters, considering her...choice in attire. <i>\"...I mean about me being a raging submissive, you idiot.\"</i>\n\n"); 
			outputText("You raise one eyebrow, telling her that you shouldn’t talk that way to you. She takes a half-step back, then brings a hand to her muff. She flings a few droplets of her musky pre at you, clearly annoyed. <i>\"You...Just promise me, please? I don’t want the others at your camp to get...Ideas\".</i> You lean in, promising her that you won’t spill the beans to your other friends, but that you and her might need to get creative.\n\n"); 
			outputText("<i>\"That’s fine, I can deal with that, just...Thank you, [name]. I’m not showing it right now, but...When we get the chance, I’m going to thank you properly.\"</i> She leans in, kissing you on the lips and pulling you into the first warm hug you’ve ever gotten from Lily. <i>\"Alright, let’s go then. All I need’s already in my bag, so…\"</i>\n\n"); 
			outputText("You lead Lily out from the forest, and she follows, making idle chat with you. You tell her about the camp, and the people you’ve met"+(camp.getCampPopulation() > 0?" and moved in with you along the way":"")+". Lily is a good listener, asking questions, occasionally prying about certain people, one finger touching her clit.\n\n");
			outputText("As you near the camp, Lily gives you a nod of approval. <i>\"Honestly, I’m impressed. Very few people have a permanent residence right now.\"</i> She points to a nearby willow tree, just outside your campgrounds. <i>\"Would you mind if I made my own dwelling over there?\"</i>\n\n");
			outputText("You nod, unable to see a reason not to let her, and as you near the tree, she gives it an approving nod. <i>\"Lots of anchor points there…I can cut here…\"</i> She visibly shakes herself, giving you a nod. <i>\"This will do.\"</i> Lily gives you a smile, twirling her fingers idly. <i>\"I’ll start immediately, and once I’m finished…I’ll finally have somewhere better than the old stashes.\"</i>\n\n");
			outputText("You leave Lily to her own devices, as she begins to spin her thread, scuttling up the trunk and weaving lines between the branches. You know from experience it won’t take her long to finish her construction, if her thread-volume before is anything to judge by.\n\n");
			LilyComeCampConclusion();
		}
		
		private function LilyComeCampConclusion():void {
			if (amilyScene.amilyFollower() && !amilyScene.amilyCorrupt()) {
				outputText("As you watch Lily leave to make her house, your mousey lover pokes her head out from a nearby rock. <i>\"Uh…Hey.\"</i> Amily comes out, keeping one eye on Lily. <i>\"Can I talk with you for a second?\"</i> You nod, and she sits down.\n\n");
				outputText("<i>\"You…You know what that is, right?\"</i> Amily has one hand on her dagger. You tell her that you do. <i>\"Then you know she’s extremely dangerous! Driders are almost universally corrupt nowadays, and the swamp’s damn near impossible to navigate because if you go near, they tie you up and rape you!\"</i>\n\n");
				outputText("You give Amily a small chuckle, telling her that she shouldn’t worry so much. You assure your mousey lover that Lily is rather unlike most Driders in that respect.\n\n");
				outputText("<i>\"What is so funny to you?\"</i> Amily demands, folding her arms over her chest. You tell her that if Amily’s worried about the big bad spider dominating her…That Lily wouldn’t get much out of that. Amily looks at you, then back at Lily, then back at you. Her mouth opens in a small ‘o’, and she leans in.\n\n");
				outputText("<i>\"So she…Uses that silk on…herself, and…\"</i> You nod, and make a ‘shh’ gesture. Amily doesn’t protest, but she gives you an odd look as she walks away.\n\n");
			}
			if (BelisaFollower.BelisaInCamp) {
				outputText("As Lily begins working on her home, your small Drider friend pokes her head out of the water, cautiously watching your newest addition to the camp. Noticing this, Lily waves you over.\n\n");
				outputText("<i>\"[name], I have a question.\"</i> Lily says. <i>\"Who is that in the water? She’s been staring at me, and while I’m flattered, it’s a little odd.\"</i>\n\n");
				outputText("You look over, and Belisa, her head poking just out of the water, eyes Lily suspiciously. You tell Lily that she isn’t the only Drider in camp, and that Belisa’s pretty shy. Lily freezes, a deer in the headlights, and slowly turns herself away from the water. <i>\"D-d-did you just say…Belisa?!\"</i> She fidgets nervously, and you take your Drider-lover’s hands.\n\n");
				outputText("You nod, and say that you’ll bring her over. Lily stands, frozen in place, as you walk over to the water. It takes you a few minutes, but you coax Belisa out from the water. As she stands, shaking the droplets from her chitin, Lily gasps, putting a hand over her mouth.\n\n");
				outputText("<i>\"It really is you…\"</i> Lily whispers, eyes widening. She looks down at her chest, as if for once wishing she had something covering it. <i>\"...I can’t believe it.\"</i>\n\n");
				outputText("Belisa approaches cautiously, seeing the tears on Lily’s face. <i>\"...Are you okay?\"</i> She stays just out of reach, looking concerned.\n\n");
				outputText("<i>\"Belisa…You look the same as before.\"</i> Lily says, tears dripping from her eyes. <i>\"The same as the night we fell.\"</i> Shocked, Belisa backs up a step, putting a hand on a knife-hilt.\n\n");
				outputText("<i>\"...Lily?\"</i> Belisa asks, fear and hope warring on her face. <i>\"...Is that you?\"</i>\n\n");
				outputText("<i>\"You’re…Unchanged.\"</i> Lily slowly steps towards her sister. <i>\"...They didn’t get you.\"</i>\n\n");
				outputText("Belisa throws herself forward, wrapping her arms around her larger sister’s shoulders. <i>\"It is you.\"</i> She blinks at the chains, and blushes slightly. <i>\"Do I want to know, sister?\"</i>\n\n");
				outputText("<i>\"Know what?\"</i> Lily seems confused, then follows Belisa’s gaze down to her own chest. <i>\"Oh…Right. No. Probably not.\"</i> She shudders. <i>\"I wasn’t as lucky as you, little one.\"</i>\n\n");
				outputText("<i>\"Lucky? No.\"</i> Belisa says, anger in her gaze. <i>\"I had two strong sisters who taught me how to hide, to use my gifts.\"</i> She breaks into tears, leaning on Lily. <i>\"Who stayed behind in the village, fought to the bitter end…So that I had a fighting chance to live.\"</i> She puts a palm on Lily’s pale cheek, a smile on her face. <i>\"And now, I have you back.\"</i>\n\n");
			}
			outputText("<b>Lily has joined you as a lover.</b>\n\n");
			LilyFollowerState = true;
			DriderTown.LilyKidsPCPregnancy = 0;
			cleanupAfterCombat(camp.returnToCampUseOneHour);
		}
		
		public function LilySex():void {
			clearOutput();
			if (LilyFollowerState) outputText("You step in, slipping one hand into Lily’s sopping quim. She gasps, shuddering, and you take a step back. Lily gives you a smirk, rubbing one of her nipples. <i>\"Oh, are we in the mood for some fun, [name]?</i>\n\n");
			menu();
			//if (player.hasCock()) addButton(1, "Fuck", name);
			//if (player.hasVagina()) addButton(2, "LickYou", name);
			if (LilySubmissivenessMeter >= 40) addButton(3, "Bondage", LilyBondage);
			else addButtonDisabled(3, "Bondage", "Req. 40%+ submissiveness.");
			addButton(4, "M.Her", LilyJillOff);
			addButton(5, "R.Play", LilyRape);
			if (LilyFollowerState) addButton(6, "3Somes", Lily3Somes);
			//if (LilySubmissivenessMeter == 100) addButton(7, "Exhibition", LilyExhibition);
		}

		public function LilyRape():void {
			clearOutput();
			outputText("Angered slightly by the Drider, you grab several globs of her webbing, left on the ground during your fight. As you stride towards her, she looks around into the trees. <i>\"W-wait, what are you-\"</i> You slap her on the cheek, knocking her off her spider legs and onto her side. <i>\"Oh...Oh no.\"</i>\n\n");
			outputText("You grab her wrist, wrenching the bow from her hand. Unstringing it, you roughly wrap the string around her wrists, binding them together. You move quickly as she tries to rise, using her own webbing to stick her legs together. Now trussed up, hands behind her back and legs bound, Lily stares up at you, speechless.\n\n");
			outputText("You strip off your [armor]"+(player.lowerGarment != UndergarmentLib.NOTHING?" and [lowergarment]":"")+", revealing your "+(player.hasCock()?"[cock]":"")+(player.gender == 3 ? " and " : "")+(player.hasVagina()?"[pussy]":"")+", and the Drider begins to writhe, struggling to undo the bindings on her legs.\n\n");
			outputText("Smirking, you rest your [leg] on her hip. You tell her that she’s going to be a good girl, or bad things will happen. To emphasize your point, you bring your [leg] to her thorax and rest your weight on her flank, slowly indenting the chitin. Lily cries out in what you assume is pain, and you let go. She falls limp, nodding once, and you take that as your go-ahead. You prop her up against a nearby tree, then start to pull on her titty-chain. She instinctively sticks her chest out, lessening the pain, and you look down at your conquest. What to do with this one?\n\n");
			menu();
			if (player.hasCock()) addButton(1, "ThrFuck", LilyThroatFuck);
			if (player.hasVagina()) addButton(2, "Facemount", LilyFaceSit);
		}
		
		public function LilyThroatFuck():void {
			clearOutput();
			outputText("You put both of your hands on her shoulders, pushing down. Her legs fold underneath her, and she closes her mouth, apparently anticipating your next move. You shake your head, grabbing the Drider’s nose and pinning her nostrils shut with one hand. You grab her hair with your other hand, shaking her head roughly.\n\n");
			outputText("She opens her mouth to breathe, and you shove your [cock] into her mouth, making her gag as you force your way past her Esophagus and down her throat. You order her to start sucking, and start moving your [hips], slapping your pelvis into her chin. The Drider beneath you gags, her throat tightening on you as you pull your shaft out, slamming it back in right after.\n\n");
			outputText("Slowly, the Drider beneath you gets into it, bobbing her head in time as you pick up the pace. Her long tongue slides under your girth, lubricating you as she uses the muscle to tighten her mouth-pussy around you. The sounds of her gagging get louder, your pre mixing with her saliva as you slam her throat with everything you have.\n\n");
			outputText("Your [cock] throbbing, your need for release building, you pull out of her throat with a wet <i>schlurp</i>, slap the Drider across the face with your [cock] for good measure, then jerk it with one hand, intent on covering your bitch with your cum.\n\n");
			outputText("You shoot a ropy load across her face, drenching her hair and forcing her to close her eyes. A second shot goes into her mouth, and a third and fourth splatter across her soft tits. Still bound, the Drider falls to her side, opening two of her eyes and staring up at you. Wiping your remaining spooge off in her hair, you walk away without untying her, satisfied.\n\n");
			lilySubmissiveness(10);
			lilyAffection(5);
			player.sexReward("saliva","Dick");
            if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilyFaceSit():void {
			clearOutput();
			outputText("Taking calm strides around your trussed up spider-slut, you drop your hands between your own legs. Gently, you rub your [clit], giving your captive a nice, long look at your pussy. You ask the Drider if she can see what’s wrong.\n\n");
			outputText("<i>\"Wha-no?\"</i> Lily pulls at her bonds, but gets nowhere. Her four massive mammaries jiggle enticingly, but she’s unable to move much. You growl, striding in and taking hold of the golden chain linking her pierced aerolae, and pull her down. The Drider falls onto her back, all six eyes wide as you loom over her. You stand over her head and diddle your twat, dripping your first drops of arousal onto her face. She closes one of her left eyes as it splashes down, and she struggles again. You shake your head, planting your feet on either side of her upper body, and lean forward, putting your quivering pussy above her mouth.\n\n");
			outputText("You smirk, telling her that if she doesn’t understand what’s wrong, that she’ll suffocate. Dropping your [ass] down onto Lily’s nose, you order your Drider-slut to get to work, your lower-lips firmly placed on top of Lily’s mouth. You force her head roughly to the ground, grinding your pussy on Lily’s face.\n\n");
			outputText("Almost immediately, you feel a slick, long muscle find the rim of your lips. Your Drider-slut has a knack for this! Her tongue flicks your clit, and you rest your weight on her head, your [ass] covering her eyes.\n\n");
			outputText("Now properly ‘motivated’, the Drider-woman underneath you latches onto you, sinking her tongue in as deep as she can. Her plump lips lock with your folds, and you can’t help but let out a little moan as you feel her fangs press against you, flat on either side of your button. You sit back, shaking your [ass] slightly as Lily’s tongue sinks into you.\n\n");
			outputText("You sink into a low, slow grind, your muff dripping onto Lily’s face as she laps at your cunt. Her lips, puffy and sticky, her nose poking ever-so-slightly at your backdoor, and the simple pleasure of watching your Drider-slut squirm are surprisingly arousing. Lily begins to cry out, her voice shaking your lower body.\n\n");
			outputText("You raise your [ass] for a few seconds, your Drider-toy gasping for air. As her tongue slides out of you, you shiver, your walls trying to clamp down, but the slippery muscle is too narrow. You grin, commenting on her lack of stamina. Before she can do more than inhale for a response, you sit on her face again, rubbing your lips all over her face, and feeling the slick warmth as it spreads, covering both her face and your thighs. Laughing a little, sadistic laugh, you tell Lily to keep licking if she wants to keep breathing.\n\n");
			outputText("She lashes her tongue deep into your folds, and it isn’t long before you start commenting on your slut’s skill, mocking her desire to keep breathing, since it’s clear all her mouth is good for is being your personal seat. You grind your muff on her face, and you can feel yourself tighten, your walls trying to milk a nonexistent cock dry.\n\n");
			outputText("Clamping your thighs down onto your Drider-slut, you let out a girly cry, your clear fluids squirting from your tongue-lashed pussy. Lily bucks underneath you as your [legs] give out, spasming from your high. You moan, stretching your [legs] as she screams into your asscheeks, flailing around and trying to get you off her.\n\n");
			outputText("Eventually you stand back up, and your Drider-slut inhales deeply, chest heaving, her face covered in your juices. She manages to roll over, coughing your clear pussy juice from her lungs. Giving her a little laugh, you stride over, smacking one of her tits hard as you grab your clothes. Lily moans, trying to free herself, but she only manages to free a single hand before you’re on your way out. She plunges her only free hand into her pussy, mouth making a perfect ‘o’. You let your [hips] sway, content that the slut’s only now starting to feel good. Maybe that’ll teach her!\n\n");
			lilySubmissiveness(10);
			lilyAffection(5);
			player.sexReward("saliva");
            if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilyJillOff():void {
			clearOutput();
			outputText("You walk up to her, forcing the drider back. Despite her best efforts, her legs are still weak, and all she does is fall backward, arching her back over her spider half.\n\n");
			outputText("The moment is perfect and you decide to take advantage, sliding on top of her, and laying a kiss on her lips. You slide your hand down to her box. She’s already soaking wet, and her arousal clings to your fingers.\n\n");
			outputText("You click your tongue disapprovingly, taking a finger into your mouth and tasting her nectar, smiling as you let go of her wrist. You tell the little drider that she’s a pretty thing when she shuts up and that she should let you have your fun. You follow your statement with a tweak on her small clit, getting another squeal out of her. She covers her mouth with her hand as her cheeks flush bright red and all but one of her eyes close.\n\n");
			outputText("You rub the tip of your finger around her pussy lips, teasing, tickling, but not entering, not yet.\n\n");
			outputText("She groans, bringing her hips towards your fingers, but you back away. She gives you a pleading look, opening her six violet eyes and moaning into her sleeve. You ask her what she wants, and she looks at your fingers. You tell her to use her words, gently, and she pouts, shuddering as you run a hand through her silky hair, spreading droplets of her fluids through it.\n\n");
			outputText("<i>\"...Stick your fingers in there.\"</i>\n\n");
			outputText("You ask her where, smiling, and her pout turns into a frown. <i>\"In my pussy. I want your fingers in my pussy...please?\"</i>\n\n");
			outputText("You smile, complimenting her, and you tweak her little clitty again, sinking a finger in up to the second digit. She takes an arrow from her quiver, and bites down on it as you pick up the pace.\n\n");
			outputText("After a few minutes of slightly faster stimulation, your little spider-toy begins fondling her lower pair of breasts, letting out louder moans through the wooden gag. <i>\"Mmmh! MmMMMH!\"</i>\n\n");
			outputText("Her femspunk covers your hand, and you sigh, wiping her leavings off in her hair. You bring a hand back to her cunt, sinking three fingers into her soaking wet quim. The Drider bucks, but you grab her chain, yanking it back towards you. Lily wails through her gag and arches her back, her sensitive breasts now pressed against you as you sink your hand into the folds of her pussy. Lily wraps her arms around you, finally embracing the moment, and you reward her by picking up the pace. Your face is pressed up against one of her breasts, and you take a hold of her succulent nipple with your teeth, running them along her sensitive areola. It doesn’t take long for the Drider’s hips to start bucking.\n\n");
			outputText("Lily spits out the arrow, unashamedly grinding her pussy into your hand. <i>\"Yes, yes...Right there...Pull my chain, please!\"</i> You see no reason not to, and you yank on her chain, pulling the bars piercing her nipples hard enough to get a high moan. The Drider’s legs spasm, and she falls to the ground, bucking her hips reflexively as her love juices pool onto the ground below her.\n\n");
			outputText("<i>\"O-oh, oh!\"</i> she lies there, a sodden mess, and you take your leave.\n\n");
			lilySubmissiveness(5);
			lilyAffection(10);
			player.sexReward("saliva","Pussy");
            if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}		

		public function LilyBondage():void {
			clearOutput();
			outputText("You stride up to your spider-toy, firmly taking her hand and pulling her closer to you. She doesn’t resist as you pull in close to her head, and whisper into her ear. You order your toy to make some silk for you, and if she does, she’ll be rewarded. You slide your hand down her robes for good measure, rubbing her labia with two fingers.\n\n");
			outputText("You’re rewarded with a little spurt as strands of silk are ejected from your spider-lover’s backside. You stop rubbing, getting a whine from Lily. You put one finger over her lips, telling her you’ll be back soon. She subsides, and you take the spider-silk, twisting it into a rough rope.\n\n");
			outputText("Suddenly, you grab her arms. She struggles, but you quickly wrap the strands around her slender, smooth limbs, tying the Drider’s hands behind her back. More strands go around her head, blocking her vision, and for good measure, you gag her.\n\n");
			outputText("Now blind, gagged and her hands bound, the Drider woman spins her head around, letting out muffled distressed sounds. You take her ear again, whispering for her not to worry, that you’re still there. You explain that this is part of the reward, and rub her sopping wet pussy for good measure. You pull back, letting her muffled cries of protest fill your ears as you decide what to do with her, now that you’ve got her all tied up properly.\n\n");
			menu();
			if (LilyFollowerState) {
				addButton(1, "Cabin", LilyBondageCabin);/*
				if (LilySubmissiveness == 100) addButton(3, "Exhibition", LilyExhibition);
				else addButtonDisabled(3, "???", "Req. 100% submissiveness.");*/
			}
			else addButton(2, "Tree", LilyBondageTree);
		}
		
		public function LilyBondageTree():void {
			clearOutput();
			outputText("You decide that there is no time like the present. You roughly pull Lily over to a nearby tree, shoving her Drider back half up against the hardwood. Blind, backed into a wall, and horny, Lily pushes back ever so slightly. You press harder, getting an aroused moan from the Drider. Lily’s protests subside, and you can see a bit of drool running down her cheek.\n\n");
			menu();
			if (player.hasCock()) addButton(1, "Vagfuck", LilyBondageTreeVagfuck);
			if (player.hasVagina()) addButton(2, "LegJill", LilyBondageTreeLilyLegs);
		}
		
		public function LilyBondageCabin():void {
			clearOutput();
			outputText("You take Lily by the chain on her four, pierced nipples, forcing her to blindly follow you into your cabin. Catching sight of one of the ceiling beams, you make a loop out of spider-silk, tossing your crude rope over the beam. Belisa squirms, letting out a surprised moan as her arms are lifted, forced up and over her head.\n\n");
			outputText("Now completely at your mercy, the drider-woman’s cunt begins drooling, and she wiggles, thrusting her hips forward and letting out little squeaks. The sight is highly arousing. She even tries to move around the cabin blind, thrusting her hips randomly, trying to find you.\n\n");
			menu();
			addButton(0, "Wait", LilyBondageCabinWait);
			if (player.hasCock()) {
				addButton(1, "AssDangle", LilyBondageCabinAssDangle);
				addButton(2, "Fuck", LilyBondageCabinFuck);
			}
			//if (player.hasKeyItem("Deluxe Dildo") >= 0 && player.hasVagina()) addButton(3, "Dildo", LilyBondageCabinDildo);
			addButton(4, "Tease", LilyBondageCabinTease);
		}
		
		public function LilyBondageCabinWait():void {
			clearOutput();
			outputText("For a few minutes, you stay perfectly still and quiet, letting her skitter around the cabin on her leash. She hits the bed with her frontmost legs, then slows down, whimpering. Her pussy is still drooling, but her whimpers of arousal begin to get lower, and sadder. You watch as she begins to think you abandoned her there, blind and gagged, with nobody to come and get her.\n\n");
			outputText("You slowly, stealthily creep up beside her, and as soon as you get close enough, you take her shoulder, spinning her towards you, and you begin to diddle her soaking twat as hard as you can, pistoning your fingers in and out, tweaking her little clitty. Her reaction is immediate. You feel her pussy walls clamp down almost painfully on your fingers, and her hips begin bucking. <i>\"MMMMM!!!\"</i> She comes almost immediately, soaking your fingers and your lower body with her femcum.\n\n");
			outputText("You shake your head, displeased at your pet’s lack of control. You withdraw your hand, and rub her leavings onto her nose, making her smell herself on your fingers.\n\n");
			outputText("Calling her a bad girl, you tell her that she’s not supposed to cum until her "+ player.mf("master", "mistress") +" does. Good girls are supposed to make their partners feel good, too. Accentuating that, you walk over to her drider back half, slapping her rear, hard.\n\n");
			outputText("You tell her that good girls get rewards. Bad girls get spankings. She groans as you palm her chitin-covered rear, right next to her spinnerets, which are twitching, pulsing. Her back legs are barely on the ground, curling up and shaking. Struck by curiosity, you stick a finger into her silk-hole, running a finger along the inside of it. The inside is smooth, and damp. Evidently, also sensitive, as touching it sends a shiver down your poor Drider-girl’s back.\n\n");
			outputText("Deciding that’s enough punishment, you go back to her front, bringing your lips to her quad breasts. She wiggles at your touch, letting little moans out as you suckle, your fingers tickling the curves of her arms through the silk bindings. After a minute or so, the drider begins grinding on your [leg], her leavings slathering your thigh. You look back at her, taking the sight in. Lily’s cheeks are bright red, and her pussy is wide open, lips swollen with blood. Her clit and nipples are rock hard, and she’s whining with need, looking at you with eyes wide and fangs dripping clear venom.\n\n");
			menu();
			if (player.hasCock()) {
				addButton(1, "AssDangle", LilyBondageCabinAssDangle);
				addButton(2, "Fuck", LilyBondageCabinFuck);
			}
			//if (player.hasKeyItem("Deluxe Dildo") >= 0 && player.hasVagina()) addButton(3, "Dildo", LilyBondageCabinDildo);
			addButton(4, "Tease", LilyBondageCabinTease);
		}
		
		public function LilyBondageCabinAssDangle():void {
			clearOutput();
			outputText("You grin, an idea forming in your head. You run your hands along her womanly back, her black hair. Lily pulls at her bindings, but you slap her thorax, right next to her silk-hole. You tell Lily to make more silk, and are rewarded with a spurt of crude strands. You slap her again, getting more silk, and you grin, wrapping several strands around each of your Drider-pet’s legs, twisting the strands together, then tossing the rope over one of the cabin’s support beams. You come back around to her front, still holding your improvised ropes. Lily tilts her head, slightly confused.\n\n");
			outputText("<i>\"Mmph?\"</i> Still gagged, she can’t ask. You grin devilishly, pulling on the ropes. Lily cries out as you pull on the rope, lifting your Drider-toy an inch or so off the ground. <i>\"Mmph?! Mmph!\"</i> Lily begins to kick a bit, but you can tell that the Drider’s more curious than apprehensive. You keep pulling until the Drider is a few feet off the ground, dangling from your cabin’s support beams by her many legs. You watch for a few seconds, content with your work, as she flails. Eventually, Lily gets used to her current situation, and you see her dripping pussy begin to leak more, swollen with her arousal.\n\n");
			outputText("You wait for the perfect moment, sliding your [cock] out of your [lowergarment]. With one smooth motion, you mount Lily, right behind her human upper body, and reach around, grabbing hold of her upper-breasts. Your [cock] slides between her soft, jiggling asscheeks, and Lily lets out another muffled moan, her legs wiggling helplessly. Wrapping your legs around her waist for extra leverage, you slide your [cockhead] into her tight anus.\n\n");
			outputText("You tweak her nipple, dropping your other hand to Lily’s rock-hard clitty. Lily squeals through her gag, and her anus loosens, giving you the chance to sink your [cock] a few inches deeper into your Drider-toy’s back passage. Her asshole is tight, almost too tight, but the sounds and feelings of a squealing, swinging Drider more than makes up for it.\n\n");
			outputText("Lily groans through the gag as you sink even deeper, finally bottoming out inside her ass. As you slowly, teasingly begin to pull back out, you run your hands along the helpless spider-girl’s hips, slowly bringing them up to cup her sensitive mounds of titflesh. Lily tries to buck her hips, but without leverage, all she manages is to swing the two of you back and forth on the odd swing you’ve made.\n\n");
			outputText("You whisper into Lily’s ear that she’s helpless, trussed up, unable to move. That she’s yours, and that you’re going to do whatever you want. You tell the Drider that you’re in her asshole, pulling <i>sloooowly</i> out, and that if she wants you to pick up the pace, well, she’s going to have to wait. This gets an immediate reaction from your toy, and she screams under the gag, rocking back and forth to try and keep your [cock] sheathed inside her.\n\n");
			outputText("Despite her best efforts, Lily doesn’t stop you from slowly bringing your [cock] to the edge of her asshole, so that only your [cockhead] remains inside. Slowly, torturously, you pull out almost all the way, before sliding back in. You repeat this slow, torturous process, nibbling on her neck, teasing her while you rub the rim of her labia. Lily’s squeals become moans, and she wiggles her legs, sending the two of you swinging.\n\n");
			outputText("You finally pick up the pace, using your [legs] to pull yourself back into her bubble butt, and sinking your fingers into her sopping wet muff. Lily begins to squeal again, grabbing your ankles and helping you push your [cock] deep into the depths of her bowels. You feel her asshole clench and unclench, and Lily screams in pleasure under the gag.\n\n");
			outputText("<i>\"Mmmm! MMMMMMM!\"</i> You feel her pussy clench around your fingers, and a deluge of sweet-smelling femspunk flows from her quim. You’re somewhat glad your Drider-toy’s gotten off, but you’re not done yet. You grab the chain connecting her tits, yanking back hard. Lily, back already arched, almost headbutts you as you renew your attack on her backdoor, slapping your hips into her bubble-butt with each thrust. Lily, still moaning, turns her head around to face you.\n\n");
			outputText("Tears are running down her face, and drool trickles from her lips. Each thrust from you gets a grunt from the well-fucked woman, and all six of her spider eyes are rolled up as she drowns in the pleasure. You remove the gag, and one of her eyes refocuses...Somewhat. You lean forward, rubbing her labia as you thrust again.\n\n");
			outputText("Gag now removed, her cries of pleasure fill your cabin, echoing off the walls in an almost musical way. <i>\"Ahn, maaah, yes! Yes, yesyesyesyes!\"</i> Lily flails under your touch, sending you both swinging wildly. <i>\"Ahahahaha! Fuck yeaaaahhhhh!\"</i> Despite your best efforts, you feel your [cock] tremble, your release inevitable. You grab Lily’s long hair, pulling her upper body back towards you as you jam your shaft in as far as it’ll go.\n\n");
			outputText("Your [cock] releases load after load into Lily’s asshole, and you tremble from on top of her. Lily moans, releasing another wave of femspunk onto the cabin floor. Weak-kneed, you lean on Lily’s upper body, resting your head on her shoulder. For a few minutes, you sit on her, catching your breath. Then, once you feel you can stand, you pull out of your fucktoy’s asshole with a moist SCHLUCK, getting a weak groan from her, and you get down.\n\n");
			outputText("Slowly, carefully, you lower Lily back to the ground, and she looks at you, two eyes focused, still drooling. Taking her cheek in your hand, you tell Lily that she was a <i>very</i> good girl. Her eyes glaze back over, and she collapses in the pool of femcum she made on the floor. Weak from your lovemaking, you see no reason not to join her, closing your eyes and collapsing onto the floor.\n\n");
			outputText("You wake up in your bed, rather surprisingly. Weren’t you just on the floor? You turn your head, and see Lily asleep beside you, one arm dangled on your chest and a completely blissed-out smile on her face. You extract yourself from her arms, tucking your itsy bitsy spider into bed. You redress, somewhat tired, but satisfied and close your cabin door behind you. Your [cock] aches a little, but you decide it was well worth it.\n\n");
			lilySubmissiveness(5);
			lilyAffection(5);
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilyBondageCabinDildo():void {
			clearOutput();
			outputText("<i></i>\n\n");
			outputText("<i></i>\n\n");
			outputText("<i></i>\n\n");
			player.sexReward("vaginalFluids","Pussy");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilyBondageCabinFuck():void {
			clearOutput();
			outputText("You whisper into her ear, asking her if she wants your big, [cock] inside you. If she wants to be stuffed, filled with cum, bred like the little spider-bitch she is. Lily groans, sticking her quad breasts in your direction. <i>\"Mmm!\"</i> You remove the gag, informing her that you can’t hear her.\n\n");
			outputText("<i>\"Mmm-yesh!\"</i> Her violet eyes are wide, and her breasts shake enticingly. <i>\"Yesh! Fuck me Pleashe!\"</i> Her purple lips are quivering, her tongue hanging out. <i>\"[name] Pleashe!\"</i> You tut, pulling hard on her nipple-chain. Not what you’re looking for. <i>\""+ player.mf("master", "mistress") +"?\"</i> You tweak a nipple, bringing your hand closer to her soaking muff. <i>\"Please Fuck me. Make me yourshe! I need it now, pleashe!\"</i> You pull your hand back, finally disrobing. You call her a good girl. You tell her that good girls get what they want.\n\n");
			outputText("You rub your erection against her thigh, grasping your drider-toy’s scalp with one hand and pulling Lily into a bruising french kiss. You slowly, tenderly slide your [cock] into her quivering folds, and she shakes, spider-legs barely holding her trembling body up. You whisper into your Drider-Toy’s ear, telling her to hold on as you plunge into her depths. She shudders, her walls clamping down on you as you pull back, and she whimpers as you nearly pull out entirely, bucking her hips forward to try and keep you inside her. You almost laugh, plunging back in, to her squealing delight.\n\n");
			outputText("<i>\"Yesh! Yesh [Master]! Pleashe keep going!\"</i> You smirk, frenching her again to shut her up as you pick up the pace. Her legs shake harder, trembling, and eventually give out as she orgasms again. You loosen the line so she isn’t putting too much pressure on her arms, barely even slowing your pace as you keep ravaging her cunt. Her screams, cries and moans get louder, her increasingly sensitive pussy leaking steadily. As she sinks to the ground, you pick up the pace again, and as she wails once more.\n\n");
			outputText("<i>\""+ player.mf("master", "mistress") +"! I want your seed, [Master]! Fill me up! Make me your little spider-bitch! I want your eggs, your-Ahhh!\"</i> Her orgasm tightens, even harder than the last, and you finally give out, unable to keep your own lust down as your [cock] twitches, blasting load after suppressed load into your spider lover’s quivering pussy. <i>\"So...Warm…\"</i>\n\n");
			outputText("Lily orgasms again, shameless as her walls milk your [cock] for all they’re worth. You ride out your high, then pull out. Lily’s stomach is slightly bigger than before, and the way her eyes are rolled back, leave little doubt in your mind that she thoroughly enjoyed this. Your spooge trickles out from Lily’s well-fucked hole, and the insensate Drider’s legs fold, dropping her to the ground.\n\n");
			outputText("You look at the back of your cabin. The entire back wall is covered with strands of Drider-silk, fresh from Lily’s hole. Deciding that your cabin should be clean, you scrape the silk off the wall before you leave.\n\n");
			if (LilyFollowerState && DriderTown.LilyKidsPCPregnancy == 0 && rand(100) < chanceToFail()) DriderTown.LilyKidsPCPregnancy = 72;
			lilySubmissiveness(5);
			lilyAffection(5);
			player.sexReward("vaginalFluids","Dick");
			inventory.takeItem(useables.T_SSILK, camp.returnToCampUseOneHour);
		}
		
		public function LilyBondageCabinTease():void {
			clearOutput();
			outputText("You grin, an idea forming in your head. You run your hands along her womanly back, her black hair. Lily pulls at her bindings, but you slap her thorax, right next to her silk-hole. You tell Lily to make more silk, and are rewarded with a spurt of crude strands. You slap her again, getting more silk, and you grin, wrapping several strands around each of your Drider-pet’s legs, twisting the strands together, then tossing the rope over one of the cabin’s support beams. You come back around to her front, still holding your improvised ropes. Lily tilts her head, slightly confused.\n\n");
			outputText("<i>“Mmph?”</i> Still gagged, she can’t ask. You grin devilishly, pulling on the ropes. Lily cries out as you pull on the rope, lifting your Drider-toy an inch or so off the ground. <i>“Mmph?! Mmph!”</i> Lily begins to kick a bit, but you can tell that the Drider’s more curious than apprehensive. You keep pulling until the Drider is a few feet off the ground, dangling from your cabin’s support beams by her many legs. You watch for a few seconds, content with your work, as she flails. Eventually, Lily gets used to her current situation, and you see her dripping pussy begin to leak more, swollen with her arousal.\n\n");
			outputText("You take a single finger, and you begin to slowly rub the very edges of Lily’s lips. Barely touching her, you run your finger along her lips, slowly, teasingly tracing your way towards her gash. Lily lets a muffled groan, thrusting her hips forward, but you saw it coming, and you pull your fingers back. You tut, telling Lily that she needs to learn some restraint. Lily moans weakly, and you order her to stay still, or she won’t get any.\n\n");
			outputText("You go back to her pussy lips, and go back to your slow, winding laps. At first, Lily’s breathing levels, and she groans occasionally when you brush her button…but as you sink a finger in, one knuckle deep, you pull it out right away. Your Drider-toy moans, shaking, and you slap her lower breast. She gasps at the sudden pain, and you look up, seeing hope in her eyes…\n\n");
			outputText("You bring two fingers to her lips, and start the slow circles again. No penetration, no release…Just slow rubs. Lily moans, her legs shaking, but she’s held up by the ropes, unable to flee, or touch herself. She strains, her front legs reaching towards her slick pussy.\n\n");
			outputText("<i>“MMMmmMMPH!”</i> Lily strains, and you stop your finger, reaching her nub. You flick her clit with one finger, and with your free hand, you reach up, palming one of Lily’s breasts, just beside her piercing.\n\n");
			outputText("<i>“Shhh…”</i> You whisper, bringing your mouth to your toy’s ear. Slowly, you resume your slow, steady strokes, but you grin, whispering sweet nothings into your toy’s ear, scraping your teeth along her neck. Her breathing speeds up, and you flick her clit again. Lily bites her lip, a bare whisper of a moan escaping her mouth. You tut, pulling her pierced nipple.\n\n");
			outputText("<i>“Mmm…”</i> Lily’s shaking intensifies, and as you sink a finger in, two knuckles deep this time, Lily shudders, a full-body spasm that shakes her on the ropes. A trickle of sticky, clear fluid flows past your fingertips, and you chuckle, taking her leavings on your hand. You wave it under her nose, and when she leans forward, smelling it, you wipe it off in your fucktoy’s hair.\n\n");
			outputText("As Lily regains her balance, you step in, wrapping one hand around her waist, resting your palm on her luscious ass. Making a firm chop with your other hand, you begin rubbing your fucktoy’s lips, up and down her gash, ignoring the lubricant dripping down your fingers and pooling on the ground below. She begins to move her hips with your hand, trying to get penetration…but you grin, sliding a finger down the crack of her ass. Realizing what’s about to happen, Lily clenches, but you slide your finger in all the same.\n\n");
			outputText("Now, you work with both her holes, occasionally pulling her chain with your teeth. When she clenches, asshole trying to milk your finger, you stop, getting a frustrated groan from Lily each time. You bring her just to the edge of cumming, only to stop. Each time, her cries of frustration get louder.\n\n");
			outputText("Finally, after three times, you turn your hand, and begin to sink five fingers into Lily’s drooling snatch. She gasps, frustrated moans giving way to a higher-pitched whine. She knows what you’re doing, but is helpless to stop you. Another time, her pussy clenches, and you stop, her walls trying to milk your fingers. Her pussy lips are swollen, and she’s started to struggle with the silk ropes. Once more, and Lily begins to cry, moaning into her gag as she wordlessly begs, eyes wet, pleading for her release.\n\n");
			outputText("You remove your finger from her ass, sliding off the gag. You finger her dripping cunt with one finger, asking her if she wants to cum.\n\n");
			outputText("<i>“Y-y-y-yes!”</i> Lily’s legs flail, and she thrusts her hips. <i>“I-I-I-I w-want…”</i> You bring two fingers in, rubbing her clit with the same slow speed. You ask her again what she wants.\n\n");
			outputText("<i>“I WANT TO CUM!”</i> She wails. <i>“Please, let me cum!”</i> You tut. Not what you were looking for. <i>“"+ player.mf("Master", "Mistress") +" please…I-I-I want to c-cum! Make me…Take me!”</i> Almost sobbing, Lily’s swollen cunt is shaking, the spider bitch is so <i>close</i>.\n\n");
			outputText("Finally, you decide to humor your little toy. Reaching in, pulling her head roughly, you french Lily, sinking four fingers into her sopping cunt. You bend her human-half back, tweaking her clit and pinning her upper body against her Spider-half. Wailing, screaming, her legs rip the silok in two places, sending her bobbing crazily. You feel something warm and wet slam into your [leg], and as you look down, you realize that Lily’s still cumming, spraying her arousal all over the cabin. Your hand is almost forcibly ejected from her cunt, each finger liberally covered in her femspunk.\n\n");
			outputText("Finally sated, Lily’s eyes roll back into her head, and she falls limp, still dangling from her silken ropes. You wipe your hand off in her hair, closing the door and heading back to camp.\n\n");
			lilySubmissiveness(15);
			lilyAffection(5);
			player.sexReward("vaginalFluids");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function Lily3Somes():void {
			clearOutput();
			outputText("You grin at your submissive Drider-bitch, telling her to hold on a second. You know that she wants some fun, but you grin, telling her that she’s going to have some other company tonight. Lily’s eyes widen in excitement, and she rubs her hands together.\n\n");
			outputText("\"Oh, "+ player.mf("master", "mistress") +", I love you!\" She cries, rushing over to your cabin. \"I’ll be trussed up for you before you get back! Please don’t keep me waiting…\" She closes the cabin door behind her, and you can all but hear the sound of her webbing being made. Who do you want to be your other partner tonight?\n\n");
			menu();
			//addButton(1, "Sidonie",LilySidonie3Some);
			//addButton(2, "Izma",LilyIzma3Some);
			//addButton(3, "Kiha",LilyKiha3Some);
			addButton(4, "Tyrantia", LilyTyrantia3some);
		}/*
		public function LilySidonie3Some():void {
			clearOutput();
			outputText("Making your way over to your horse-girl’s part of camp, you catch Sidonie taking an odd piece of rough paper to a table leg. As you approach, however, she stops, wiping some sweat off her brow. \"Oh, what brings you over here?\" Sidonie asks, her eyes glinting. She smiles, flapping her loose shirt to dispel some heat. \"Anything I can help you with?\"\n\n");
			outputText("You tell Sidonie that a mutual friend of yours needs some treated wood...but that her carpentry skills won’t be required. Sidonie blinks, then shakes her head, sending her mane every which way.\n\n");
			outputText("\"I guess I could spare some time. Is it our needy little spider?\" You nod, and Sidonie rubs her hands together. \"Lead the way, [name].\"\n\n");
			outputText("You enter the cabin, opening the door for Sidonie. She puts a hand on her chest, stomping one hoof. \"Oh, how nice of you.\" She looks inside, and sees Lily, her mouth open and dripping saliva, mock-struggling, her slender arms tied behind her back with the line already draped over the timbers. Her chest heaves as she sees the two of you enter, her cunt already drooling\n\n");
			outputText("\"Well, this is your party.\" Sidonie walks over to Lily, tightening the restraints on her arms. Sidonie pulls hard, her muscles more than sufficient to lift Lily’s upper body up off the ground. She ties the line to your bed, leaving Lily partly dangling by her arms. \"How do you want to play?\"\n\n");
			menu();
			//addButton(1, "LilySpit",LilySpitRoast );
			addButton(2, "S.Sandwich", SandwichSidonie );
			addButton(3, "S.Dom", SidonieDom );
		}
		
		public function LilySpitRoast():void {
			clearOutput();
			outputText("\n\n");
			player.sexReward("vaginalFluids");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function SandwichSidonie():void {
			clearOutput();
			outputText("You undress, your [cock] already rock hard. You give yourself a pump, then slide over to Sidonie. You slowly strip your equine lover, giving Lily plenty of time to take in the luscious breasts, the heavy muscles, and most of all, the massive tool of Sidonie. You tell Sidonie that she gets her turn first, and that you’ll jump in after you...warm yourself up.\n\n");
			outputText("Lily squeals in delight, wiggling her breasts as much as she can to entice your mutual lover. \"O-oh, yes! Sidonie! "+ player.mf("master", "mistress") +" has great taste!\" Sidonie takes a hold of Lily’s top breasts, kneading them in her strong hands before lining herself up with Lily’s cunt.\n\n");
			outputText("\"Oh yeah, s/he does.\" With that, Sidonie slides herself forward, slowly filling your submissive Drider. The first five inches go in slow, and Lily whimpers, wrapping her arms around Sidonie’s large frame, their breasts smooshing together.\n\n");
			outputText("\"O-oh...You’re...so big…\" Lily whimpers, grinding her hips. Sidonie lets her move, slowly but surely pushing her massive cock further in. As the two ladies lean in, pushing their massive mammaries aside and locking lips, you slyly untie the line keeping Lily’s hands bound, then you walk in, grabbing hold of Sidonie’s balls. She leans in, getting another gasp from Lily, but to Sidonie’s shock, you take your [cock], running your shaft between her luscious asscheeks.\n\n");
			outputText("\"Oh...hey…\" Sidonie stops for a second, her voice a little shaky. \"What are you…?\" You line yourself up with Sidonie’s horse-pussy, rubbing her lips, and she gasps as you grab her hips and thrust, burying half your [cock] into her in one swift motion. Her pussy is warmer than most, with ample lubricant. The muscular woman clenches instinctively, but you’re already inside, and all it does is make her folds that much tighter for you.\n\n");
			outputText("\"Fuck..\" Sidonie turns her head to face you, her tongue lolling out. \"Haven’t...\" You ask her what she expected. You tweak her clit, telling your lover that her shaft can’t get all the fun. You push further in, and she mirrors the action, sinking herself into Lily. Both of your ladies gasp, and you lean in, cupping her sizable gnads in your hand.\n\n");
			outputText("Teasingly, you ask your horsey lover if she’s not used to taking wood. Sidonie gasps as you shift your hips from side to side, feeling every nook and cranny of Sidonie’s tight cunt. \"Not used to...catching, [name].\" Sidonie responds, inhaling sharply as you knead her balls around. You ask her if you want her to stop. Sidonie stops for a moment, but in response, she leans back into you, burying your [cock] into her depths. \"I didn’t say that…\" She manages, before you lean in, pushing Sidonie into Lily’s waiting grasp.\n\n");
			outputText("You order Lily to keep Sidonie in place, and your Drider-toy is more than happy to comply, wrapping her arms around Sidonie’s muscular frame and sandwiching the horse-morph between you. \"Lily, I-Mmph!\" Sidonie’s voice is stopped as Lily locks lips with her. The towering horse-morph reaches up, grabs Lily’s head, and leans in, her pussy clamping down on you even tighter. You buck your hips, burying yourself to the hilt into Sidonie, and she lets out a muffled cry, mirroring the action into Lily, who grins, teasingly tracing Sidonie’s muscles as the horse-girl fucks her cunt.\n\n");
			outputText("You sink into a swift, steady rhythm, and Lily hums a happy tune, occasionally reaching around to put a hand on your shoulder, or wink three of her spider eyes at you between pulls on Sidonie’s tits.\n\n");
			outputText("Pinned, attacked from both sides, Sidonie begins to sweat, her pussy muscles writhing. \"F...Fuck...You two…\" She breathes heavily, grabbing hold of Lily’s upper body. \"I’m gonna…Sidonie’s entire body seizes up, and the towering horse-morph yells through clenched teeth. Your [cock] twitches inside her, and you feel a torrent of girlcum run down your shaft and out, drenching your lower body. Lily tightens her grip on Sidonie, her greedy cunt lips touching your fingers, still around the horse-girl’s balls. Lily wails, wrapping her front legs around both Sidonie, and you, as her cunt begins to drool, Sidonie’s seed dripping down her balls and onto the floor.\n\n");
			outputText("\"Yes, Sidonie!\" Lily cums hard, drenching the floor of your cabin. Sidonie falls forward, but you’re not quite done yet. In the throes of her orgasm, Lily’s trapped under the giant horse-woman. Still on her knees, Sidonie gasps as you pick up the pace, her entire body trembling as you grab her wide hips for leverage, fucking her from behind.\n\n");
			outputText("You’re close, but you hold it, not wanting the moment to end yet. Despite her misgivings, Sidonie’s clearly enjoying herself, her legs twitching with every thrust. She lets out a girly scream, her hips bucking back into you, and Sidonie arches her back, pulling away from Lily’s tight embrace.\n\n");
			outputText("\"Fuck! Ah!\" She turns her head to face you, tongue lolling out. Her eyes are wide, a blush high in her cheeks. With one final wail, she clamps down on you like a vice, her second orgasm finally sending you over the edge. Grabbing hold of Sidonie’s shoulders, you push yourself in, to the hilt, spurting load after load into her greedy pussy. Her walls milk you for all she’s worth, and Sidonie falls to the left, gasping for air as she pulls you out of her. Her eyes close, and her breathing slows. Your horsey lover’s fallen asleep on you.\n\n");
			outputText("\"Oh...Maybe she...Got a little too into it.\" Lily giggles, her own pussy dripping with Sidonie’s spooge. \"Poor dear.\"\n\n");
			outputText("Exhausted though you are, Lily and you pull the blankets off your bed, folding them into pillows. You lay down on either side of Sidonie’s unconscious frame, her body putting off more than enough heat to keep you warm as you drift off to sleep. Sidonie opens her eyes as you snuggle in, and a small smile forms on her face as she pulls the two of you in.\n\n");
			outputText("\n\n");
			player.sexReward("vaginalFluids");
			LilyAffectionMeter += 10;
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function SidonieDom():void {
			clearOutput();
			outputText("Slipping your hand down Sidonie’s hotpants, you grip her tool. She flinches, but doesn’t move. You tell Sidonie that you’ve always wondered what Lily saw in being the bottom...Until now. You slowly, sensually begin to stroke Sidonie off, rubbing the tip of her glorious tool until she pulls her hotpants down, her veiny rod on full display. Lily, watching, blushes bright red, her own cooter still dripping with lust.\n\n");
			outputText("You whisper into Sidonie’s ear that you want her to dom you both tonight...if she feels up to it. For a second, your equine lover is still...Until she grabs your arms roughly, slamming you down onto the bed, face down.\n\n");
			outputText("\"More silk, bitch\", Sidonie says, and you feel her roughly binding your hands. A few seconds later, you feel your [armor] sliding off your body, Sidonie’s hands sliding up your now naked flank. She flicks your little nub once, teasing you, before flipping you over.\n\n");
			outputText("\"Sit up, and let me see what you’ve got.\" Lily spreads her spider legs wide, tongue lolling out, thrusting her hips towards Sidonie. Your equine lover whistles, stepping in and giving Lily’s black legs a rub. She leans in, inhaling Lily’s scent, before giving her clit a lick. Lily shivers, and Sidonie pats her on the head.\n\n");
			outputText("\"Good girl.\" Sidonie strides to you, and you rub yourself, spreading your legs and letting Sidonie see your [pussy]. She grins, sliding a finger into you. You shudder as she leans in, slowly moving her finger through your folds. She leans over you, her soft breasts pressing in on your face and neck. \"Mm, you like what you feel?\" She slides her hoof-like nails in deeper, gently scraping your folds, and you tighten, silvery shocks of pleasure running through you. You nod, and she smiles, wrapping her arms around your neck. \"That’s right.\"\n\n");
			outputText("Sidonie takes a step back, giving you a little smirk. \"I think I know who’s going first.\" She cups her balls in one hand, her horse-cock already mostly free from its sheath. She walks over to Lily, leaning over the Drider’s upper body. Sidonie forces Lily back into the wall, hand reaching around to finger the spider-girl’s ass. Lily’s eyes widen as Sidonie rubs her horse-cock against Lily’s dark pussy lips, and your horse-girl whistles, her tender jugs jiggling ever so slightly as she runs her massive cock along Lily’s lips, slathering her shaft in Lily’s pre before she lines up her flared cockhead with Lily’s chasm. \"Now, I don’t want to hear a whimper from you, little bitch.\"\n\n");
			outputText("Lily’s legs quiver as the massive cock starts to slide in. Sidonie stops, then stabs in a few inches, her large hands pinching Lily’s nipples as she alternates between quick jabs and no movement. A small whimper escapes Lily’s lips as Sidonie bottoms out, and you wince slightly, knowing what’s coming next.\n\n");
			outputText("\"I thought I didn’t want to hear that.\" Sidonie teases, her voice low and dark. \"You know what happens to bad girls.\" She slaps Lily’s bottom-left breast, hard enough to send the entire quadlet bouncing around.\n\n");
			outputText("\"N-No! I’m being good!\" Lily wails, but Sidonie shakes her head, pulling out in one smooth motion. Lily clenches her teeth over a wail, but the horse-woman isn’t done, walking to Lily’s soft backside. Sidonie slaps Lily, once, twice, three times, but gets no cry of pain.\n\n");
			outputText("\"Pain doesn’t really work on you, huh?\" Sidonie asks, putting one foot over Lily’s Spider half. She slides in behind Lily’s upper body, groping her top pair of breasts as she nibbles her neck. \"But you really like this dick, don’t you?\" Lily nods, and Sidonie gives her a low growl, running her shaft through Lily’s asscheeks. She pumps them once, twice, before stepping off and away. \"Well, bad girls don’t get what they want.\" She cups her massive dong, running two fingers up its glorious length, before wiping her hands off in Lily’s ebony tresses. \"Sorry, little spider, but I’ve got a good girl over here.\"\n\n");
			outputText("You gasp as Sidonie locks eyes with you, and her eyes immediately drop to your [pussy]. Already dripping from the show she put on for you, she steps in, grabbing a hold on your neck. It isn’t tight, but she’s obviously enjoying the feeling of power. You let her ‘force’ you to your knees, and almost before she opens her mouth, you’re already leaning in, rubbing your cheek along the length of her glorious shaft. You can smell cinnamon, ever so slightly, but it’s overpowered by the scent of Sidonie, like leather and sandalwood...and the musk of her pre. She rubs her massive tool all over your face, slathering her pre on your cheeks.\n\n");
			outputText("Sidonie grunts, your vaginal walls almost painfully tight on her massive equine cock. You feel her grab your hips, wiggling hers from side to side as she slowly pries herself free from your deliciously tight chasm. \"Wow…[name], you really know how to keep a girl inside, huh?\" You feel her crown catch on your inner lips, the last bit of resistance before Sidonie exits your cunt with a moist pop\n\n");
			outputText("Catching her breath for a moment, Sidonie glances back at Lily, wiggling her hips to try and get her back, and gets a glint in her eye. She walks around to you, undoing the bindings around your hands. \"Now, I know you both want more of this\", she says, stroking herself once. \"But I don’t want my ladies getting jealous. Why don’t you kiss and make up?\"\n\n");
			outputText("You struggle to your feet, more than willing to obey your equine mistress. You walk over to Lily, and before the Spider-girl can react, you step into her, wrapping your [arms] around the Drider, one hand on her palmable ass, and the other on the back of her head. You pull Lily into a sensual french, her six eyes half-closing as she leans in.\n\n");
			outputText("Without her arms, she can’t embrace you, but to your surprise, a second later, she leans in, slipping a finger into your backdoor and pressing her soft quad-breasts into your [chest], the metal of her chains warm with her body heat. She pulls on your [chest] with one hand, slipping her other down to rub your inner thigh, her tongue clashing with yours. You pull your head slightly back, letting her see your wide lips, saliva dripping down Lily’s cheek and yours, before she moans, pulling you back in. You and Lily tilt your heads, still making out, to see Sidonie out of the corner of your eyes.\n\n");
			outputText("Her equine dong hangs out, ramrod straight, and your eyes drop right to it, as does Lily’s. \"Oh, [name], would you bend my little bitch-spider over for me?\" Sidonie asks. \"Oh, and cover her mouth.\" Playfully, you kick Lily’s front two legs, one after the other, and as she falls, you grab hold of her, forcing her upper body back against her shell, with you on top. You silence Lily’s muffled protest with a kiss, lining up your [pussydesc] up on top of hers, your lips swollen, drooling a mixture of yours and Sidonie’s cum onto her black chitin.\n\n");
			outputText("You feel Lily’s legs scramble as Sidonie pushes in behind you, her thick thighs rubbing against yours. She slides her monster cock in, lining it up with your eager fuckhole, and you turn your head to look back, breathless with anticipation. She shakes her head, lining it up with Lily’s twat instead. The spider-sub opens her mouth in a perfect o, but the penetration doesn’t come. Lily moans, frustrated, as Sidonie slides her monster cock between you, flared tip catching on your belly button briefly.\n\n");
			outputText("Lily pushes up against you, bringing one hand to your muff and jilling you off. Her spider legs try to rise, to stop Sidonie from going between you again, but Sidonie sees this coming. Her shaft runs between you and Lily, the slickened shaft spreading your mixed fluids onto Lily’s stomach and yours. Your cunt drools, your button sending shivers of pleasure up your spine as her equine dong parts your lips and Lily’s.\n\n");
			outputText("The rattle of Lily’s chain, muffled between her luscious mounds and your own [chest], enters your ears. Lily tries to throw you off, to flip you over, but you counter by pulling her chain, wrapping your [legs] around her. To Lily’s delight, Sidonie lines her flared tip with her quivering folds again, this time sinking in, slowly. You can feel Lily’s stomach bulge, your horsey lover’s cock pushing against you, even through Lily’s skin.\n\n");
			outputText("Sidonie grunts, and you feel her strong hands grab your shoulders, using you for leverage as she fucks Lily. With each thrust, Sidonie’s abs hit your ass, and you french Lily, fingering yourself with your free hand.\n\n");
			outputText("It only takes a few minutes for your spider-bitch to begin bucking, shaking her hips as fast as she can. Sidonie moans, bringing her face down, parting your asscheeks with her nose and lapping at your cunt. This goes on for a few minutes, before Lily wails, spider-legs unable to hold her anymore. The fucked-senseless Drider sprays all three of you with her femspunk, and a moment later, you feel a twitch, your only warning before Lily’s stomach bulges, thick white cum flowing from her cunt. Sidonie pulls out, a satisfied smirk on her face, but she only takes the time to pump her tool twice, wiping the spare cum off on Lily’s leg, before she slaps your ass, hard.\n\n");
			outputText("\"Oh, you’ve waited so patiently\", Your equine lover remarks, her soft breasts dripping mixed fluids. \"Here’s your reward.\" She grabs your hips, but before she sticks herself in, she yanks, hard, flipping you over onto your back. \"Lily, would you mind making sure my other bitch doesn’t go anywhere?\" Surprised, and somewhat disorientated, you’re unable to process this before Lily takes your arms, locking her fingers behind your head.\n\n");
			outputText("\"Oh, now for the fun part.\" Lily whispers. She sinks her teeth into the side of your neck. Heat rushes to your now-throbbing clit, and you gasp, looking up at Sidonie, who now leans over you, cream-gold fur matted with various fluids. Lily’s legs slide up, forcing your [legs] apart. Sidonie licks her finger, then runs the moist digit down your thigh, then slowly back up, her other hand groping your [breasts]. She seems content, but you need her. Between the foreplay, the massive cock in front of you, and the venom coursing through your veins, you need this. Now. You try to break Lily’s hold, but the Spider-bitch just tightens her grip, giggling at the thin trail of lubricant running down your [legs] You look up at Sidonie, but your horsey lover is smirking, clearly enjoying your plight.\n\n");
			outputText("\"Oh, you really like what you see, don’t you slut?\" Sidonie drawls, slapping her flared cockhead against your thigh. \"I mean, look at all this.\" She cups some of your pre in her hand, rubbing it on your stomach. \"You’re a slut, [name]. A bitch for my cock.\" Sidonie rubs her flared tip against your pussy lips. \"Aren’t you?\" You nod, but she tuts, pulling back.\n\n");
			outputText("\"Close, but not what I want.\" She slaps your thigh, sending ripples down into the Drider below you. \"I want you to admit it, ‘champion.\" Your breathing quickens, and Sidonie slaps her cock against your clit. \"Well?\" You need her, you can’t hold on anymore! Your voice comes out, high and needy. You beg Sidonie to fuck you, to fill your needy pussy. Right now, you’re not a champion, a warrior...no, you’re just a bitch in heat who needs to get fucked.\n\n");
			outputText("Sidonie leans in, resting her soft tits against Lily’s back. She thrusts forward, flared tip forcing your lips aside, slowly, torturously easing into you. Pinned under Lily’s warm carapace, you’re unable to move. Sidonie’s flared horsecock pushes deeper into you, spreading your folds wide and touching the tip of your womb. You gasp, feeling her flared tip, and she grins, pulling nearly her entire length out from your cunt.\n\n");
			outputText("Trapped between your two lovers, you gasp as one of Lily’s legs reaches up your thigh, tickling your [skin] before rubbing the tip of her leg against your clit. Sidonie’s horsecock slides down your folds, tip pressing against your womb. it doesn’t take long for your breathing to get ragged, each movement sending silver shocks of pleasure up your spine. Lily’s aphrodisiac venom fills your head with pink, and you buck your hips into each motion, getting a warm hum of approval from Sidonie.\n\nn");
			outputText("Her horse cock begins to twitch, and as Lily moans, sinking the tip of her leg into your ass, you can’t hold back any longer. Slamming your hips up, sinking Sidonie balls-deep into your quim, you clamp down, wailing as your femspunk squirts around her throbbing cock and out, spraying your equine lover’s chest with your leavings. You feel her throb, her flared tip burying itself into you, poking the entrance to your womb as she cums, filling your thirsty cunt. She thrusts a final few times, burying her baby-batter deep inside you.\n\nn");
			outputText("Sidonie collapses backwards, pulling you down with her. She’s still inside you, and you moan at the rough final thrust, rolling to one side. Sidonie lies on her back, and as you roll, her flared tip leaving your folds, she pulls you back in, your head resting on her shoulder. Lily joins you, on the other side of Sidonie, and the horse-girl wraps an arm around Lily’s neck. The three of you lie there, breathing heavily.\n\nn");
			outputText("“Damn, you two.” Sidonie gasps, breathless. “You’re a pair of damn fine sluts.” She kisses Lily, then you before letting her head rest on the floor. “This was fucking great.”\n\nn");
			outputText("Lily lets her “tk-tk-tk” laugh, and sighs happily, sticking her fingers into her cum-sticky cunt. “You said it.”\n\nn");
			outputText("You rest there on the floor for a while, before Sidonie’s eyes widen. “Oh, shit! I need to sand out that lumber before tomorrow!” She gently extracts herself from you and Lily, tossing her clothing on before running out the door.\n\nn");
			outputText("“Y’know…We could be carrying half-siblings”, Lily whispers. “Hmm?” You look down at your own cunt, Sidonie’s spooge dripping down your thigh. You reluctantly agree, and embrace Lily. You cuddle together for a little bit, but you need to leave as well\n\nn");
			outputText("Lily gives you a wink as you leave. “Don’t keep me waiting, please?”\n\nn");
			LilyAffectionMeter += 10;
			player.sexReward("vaginalFluids");
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilyIzma3Some():void {
			clearOutput();
			outputText("\n\n");
			menu();
			addButton (1, " ", );
		}
		public function LilyKiha3Some():void {
			clearOutput();
			outputText("\n\n");
			menu();
			addButton (1, " ", );
		}
		
		public function LilyExhibition():void {
			clearOutput();
			outputText("You take your spider-slut to the camp wall, and with a few swift motions, you tie her back legs up, binding her back-half to the wall. You throw the rope on her hands over an outcropping, forcing the Drider’s hands over her head. The wind picks up, and Lily realizes that she’s outside.\n\n");
			outputText("\"Mmm? MMMMHM?!\" She begins to struggle, but you step in, kissing your little slut on the mouth. She leans in, but you quickly back your head away, sinking your fingers into her already soaking twat. Running your fingers along her pussy, teasing her mercilessly, you bring your lips to her ear.\n\n");
			outputText("You ask Lily if she knows where she is. She shakes her head, and you lean in, letting your voice drop. You tell her that she’s tied to the wall. The Drider begins poking around with her unbound legs. You tell her that it’s time for your itsy bitsy spider slut to come out to the camp. You tell Lily that you’re going to give her the best reward she’s ever gotten, and it’s happening right here, right now. Now frozen in place, Lily begins to whimper through the gag. Despite this, she isn’t giving you her usual signal to stop, so…\n\n");
			outputText("You raise your voice, yelling for the entire camp to hear. You declare that someone needs to introduce themselves to everyone, and that she’s promised to take care of everyone’s needs for today. You slap the insides of Lily’s frontmost legs, forcing them open so that everyone present can see your Drider-toy’s sopping wet muff.\n\n");
			//Various NPCs reactions here: Need to use Kflags for most, and IDK what those Kflags are. Not interested NPCs here
			// Pure Amily
			outputText("Amily notices Lily tied up, she looks as if she wants to say something, but instead grimaces slightly before walking off.\n\n");
			//Arian
			outputText("Arian pokes [his/her] head out from [his/her] tent, sees the tied up Drider, and blinks twice. Apparently realizing that [he/she]’s not seeing things, [he/she] shakes [his/her] head disapprovingly. A small bubble of translucent energy forms around the tent, and you have the feeling it’s some kind of soundproofing spell.\n\n");
			//Belisa
			outputText("Belisa sees you take Lily, and her eyes widen. She fans herself, blushing wildly, before going into her house and shutting the silk door behind her. Something tells you she’ll be in there until you’re done.\n\n");
			//Chi Chi
			outputText("Chi Chi looks up from her training, sees your Drider-slut, and exhales angrily. She punches one of her dummies so hard she shatters the thing, then strides away into the woods.\n\n");
			//Diva
			outputText("Diva hears the ruckus, poking her head out, then rolls her eyes. \"Thou art making a mockery of both lovemaking and Dungeons\". She then goes back to sleep. \"Wake me at thoust peril\".\n\n");
			//Pure Jojo
			outputText("Jojo notices your display before shielding his eyes and turning away, wanting none of your lewd nonsense.\n\n");
			//Siegward
			outputText("Siegweird gives a disapproving glower, but otherwise, the paladin does not approach\n\n");
			//Zenji
			outputText("Zenji remains on top of his tree, peering at you and your bound accomplice, he seems disinterested in the proceedings.\n\n");
			//Ember
			outputText("Ember sticks her head out of her lair, seeing you establish your dominance. She rolls his/her eyes at the crass display, taking off.\n\n");

			//Interested NPCs here.

			//Kiha
			outputText("Kiha stares at your display, mouth wide open, then harrumphs, turning her head away. When she thinks you aren’t looking, she turns her head back, rubbing her knees together nervously. You can see the moisture dripping from her legs.\n\n");
			//Joy
			outputText("Joy sees the tied up Drider, and her eyes light up. Joy walks closer to the display, bobbing back and forth, her little tail waggling as she raises her hand to get your attention. Something tells you she’s not really interested carnally, but she could be entertaining, nonetheless.\n\n");
			//Corrupt Amily
			outputText("Amily's tail slides up and down her legs, stroking herself eagerly, but the obedient slut won't approach unless it's demanded of her.\n\n");
			//Electra
			outputText("Electra sees the scene unfolding, her ears perking up with interest. She slides over, static sparking across her body as she sees the helpless Drider.\n\n");
			//Etna
			outputText("Etna perks up at the lewd display, scampering over and rubbing her pussy-tail on her thigh. \"Nyaaa, how fun!\"\n\n");
			//Tyrantia
			outputText("Tyrantia grins, grabbing her Dick and standing not far away. Something tells you she wants to stick her Dick in her little sister.\n\n");
			//Izma w/dick
			outputText("Your shark-lover, Izma(el) surfaces, seeing your display. Already rock-hard, [he/she] approaches, a grin on [his/her] face. \"Having some fun, my Alpha?\"\n\n");
			//Sidonie
			outputText("Sidonie sees the tied up Drider, waggling her eyebrows at you. You notice that she already has a tent in her pants, and she walks over, eyeing up Lily. \"Interesting. Caught some fresh meat for us, [name]?\n\n");
			menu();
			addButton(1, "Etna", LilyExEtna);
			addButton(2, "Electra", LilyExElectra);
			addButton(3, "Izma/el", LilyExIzma);
			addButton(4, "Joy", LilyExJoy);
		}
		*/
		public function LilyBondageTreeVagfuck():void {
			clearOutput();
			outputText("You step in, slapping Lily’s front legs aside. Smiling, you disrobe, pulling your [cock] out. Taking your shaft in one hand, you rub yourself, blood rushing to your [cock]. Now rock-hard, you look at your tied up fucktoy as she moans, her pussy already dripping.\n\n");
			outputText("You run your [cock] along her pussy lips, getting a gasp from Lily, and you reach up, rubbing one of her pale breasts. You thrust once, twice, getting yourself all nice and slathered in Lily’s juices before lining your [cockhead] up with her glistening black cunt.\n\n");
			outputText("Her cunt offers little resistance, and you push in, rings of muscle squeezing just tight enough to let you feel her walls, the slick chasm of ringed muscle working in waves, trying to pull you in ever further. Lily’s front legs wrap around you, and you begin fucking her in earnest. Still gagged, Lily can only let out moans as you push back, her legs yielding as your [ass] shoves them aside before plunging back in.\n\n");
			outputText("Her moans intensify, and you can see tears running down past the blindfold, Lily’s tongue sticking out past the silky gag as she thrusts her hips in time with your thrusts. Suddenly, her front legs tighten, pinning you against her as she bucks. Her walls tighten, almost painfully tight on your [cock], and you yank her chain, pulling her pierced tits. You choose one at random, biting down on the sensitive titflesh, and you feel your [cock] twitch as Lily’s pussy spasms, walls writhing as a stream of femcum passes over your shaft, trickling down your thighs. This last bit of stimulation sets you off, and you thrust as deep as you can, [cock] twitching as you fire a load of your baby batter into Lily’s still orgasming pussy. Lily’s wails give way to a low moan, and you take the gag off.\n\n");
			outputText("Lily breathes heavily, tongue hanging out. <i>\"FuuuuUuuuuuuuck,\"</i> she moans, hips twitching. <i>\"You…Really…\"</i> You take the blindfold off, and Lily looks down at you, six eyes barely focused. <i>\"Mmmmm…\"</i> You pull your [cock] out, getting a full-body shudder from Lily as her legs give out, and she falls to the grass, humanoid upper body laid across her Spidery lower half. Her pussy gapes with the fuck you just gave it, blushing black lips drooling a mixture of clear and white. She closes her eyes, a blissed-out smile on her face, and she starts snoring.\n\n");
			outputText("You decide to let her sleep her post-sex exhaustion off, wiping your [cock] off in her hair before heading back to camp.\n\n");
			player.sexReward("vaginalFluids", "Dick");
			lilySubmissiveness(5);
			lilyAffection(5);
            if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilyBondageTreeLilyLegs():void {
			clearOutput();
			outputText("Eyeing the Drider-woman’s spider-legs, you get an idea. You put your hands on her shoulders, forcing the Drider to lie down. You take the tip of her leg in one hand, running your fingers along the smooth chitin.\n\n");
			outputText("You remove your [lowergarment], picking one of her middle-front legs. You sit down, spreading your legs and running your hands along Lily’s chitinous limb. She lets it fall limp, and you run your new toy along the inside of your [leg], running it up your thigh. You feel your Drider toy shudder, and you slap the tip of her foot.\n\n");
			outputText("She stills, and you rub the warm limb. Your pussy quivers, and you gasp slightly as you slip the stiff limb tip into you. The chitin is quickly slickened by your moisture, and you pull your Drider-toy’s leg further in. Now realizing what you’re doing, Lily groans, knowing that she won’t be satisfied until you are.\n\n");
			outputText("You tell Lily to start moving, and you moan, rubbing your nub as she sinks her leg in slightly deeper, before slowly, blindly pulling it back. You put one hand on your [breasts], squeezing them one after the other. After a few strokes, Lily seems to get the hang of it, twisting her spider leg a little with each stroke.\n\n");
			outputText("<i>\"Faster\"</i>, you order, and Lily obeys, her segmented leg sinking slightly deeper, poking the entrance to your womb. You buck your hips, your cooter practically drenched by now. Her leg slides in, each little bit of chitin smooth, but as it runs along each fold, Lily’s ‘foot’ moves, the clever Drider scraping your insides with her ‘toe’.\n\n");
			outputText("Letting out a wail, you clamp down, grabbing the grass below you as you feel yourself clamp down on her leg. Despite your wails, Lily keeps going, pistoning in and out with abandon. In no mood to stop her, you buck wildly, [tongue] hanging out of your mouth in a whorish expression.\n\n");
			outputText("Your lust finally spills over, and you close your eyes, spraying your juices all over Lily’s leg. She pulls out of you, and you wince at the sudden lack of fullness inside you. You roll over, your juices still gushing down your leg.\n\n");
			outputText("Lily is being a good girl, you realize as you come down from your high. She’s made no move to jill herself off, and is waiting for you to recover. As you breathe heavily, she bites through her gag, her voice a whine.\n\n");
			outputText("<i>\""+ player.mf("master", "mistress") +", I’ve been a good slut. I d-did what you asked for...so please, can you make me feel good too?\"</i>\n\n");
			lilySubmissiveness(10);
			lilyAffection(10);
			menu();
			addButton(1, "Lolno", LilyDenied);
			addButton(2, "Sure", LilyReward);
		}
		
		public function LilyDenied():void {
			clearOutput();
			outputText("You laugh, saying that if she’s a good girl and isn’t so needy next time, you’ll consider it. She wails, flailing angrily against the restraints as you redress and walk away.\n\n");
			lilySubmissiveness(5);
			lilyAffection(-5);
            if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		public function LilyReward():void {
			clearOutput();
			outputText("You stand, shakily, and lean in. You pull the gag aside, further down her neck, and you remove the blindfold. Lily’s eyes are widened, worried, but as you bring a hand to her dripping pussy, flicking her black button, the relief on your Drider-toy’s face is obvious.\n\n");
			outputText("<i>\"Thank you, "+ player.mf("master", "mistress") +"\"</i>, Lily whispers, her back legs tapping the ground. You reach up, grabbing her raven hair and pulling Lily’s upper body back down towards her Spider-half. Leaning over her, you force her mouth to stay open, frenching her with brutal abandon as you sink two fingers into her dripping sex. Your [chest] and hers grind, her soft, supple flesh almost like four pillows.\n\n");
			outputText("You rest more and more of your weight onto your Drider love-toy, pinning her upper body down. Taking her hands, one after the other, you lead one of her hands to your still-sopping pussy, and her other to your ");
			if (player.hasCock()) outputText("[cock]. She begins expertly jerking you off, the pressure on your previously unstimulated shaft"+(player.cockTotal() > 1 ? "s":"")+" almost enough to get you off again.");
			else outputText("[breast]. She takes a nipple in two fingers, rolling the nub around and pulling on it.");
			outputText(" (Split end) She rubs the rim of your labia, teasing your sensitive clitty before scraping her nails into you, slowly, slowly, she moves the tip of her finger deeper into your already-fucked pussy.\n\n");
			outputText("You rub your pelvises against each other, pleasuring each other for some time. Lily moans louder and louder into your mouth, her eyes all closed, and her tongue running along the inside of your cheeks. Finally, she bucks, her entire body moving underneath you as you feel her clamp down hard on your fingers. The smell of sugar fills the air, with the tang of vinegar following shortly afterwards as Lily nearly throws you off her entirely. You groan as her fingering intensifies, wrapping your arms around her waist and holding on for dear life. <i>\"Cum for me, [master], let me know you love me.\"</i>\n\n");
			outputText("You buck, wailing as your pussy clamps down again, her fingers stirring you up even as you orgasm. You buck on top of your whorish little spider, collapsing in a sodden mess on top of her.\n\n");
			player.sexReward("Default", "Vaginal", true, false);
			lilySubmissiveness(5);
			lilyAffection(5);
            if (CoC.instance.inCombat) cleanupAfterCombat();
			doNext(camp.returnToCampUseOneHour);
		}
		
		private function chanceToFail():Number {
			var chance:Number = 10;
			chance += Math.min(player.cumQ() / 25,40);
			chance += Math.min(player.virilityQ() * 100, 50);
			return chance;
		}
		
		public function LilyCampFollower():void {
			clearOutput();
			outputText("As you approach Lily’s silken treehouse, you see a golden chain dangling from the tree. You look up, and get splashed on the head by your Drider-lover’s pussy juice.\n\n");
			outputText("<i>\"Hello,\"</i> she says from the tree, a smile on her face and one hand over her mouth at the naughty prank she just played.. <i>\"How are things, " + ((LilySubmissivenessMeter >= 80)? player.mf("Master", "Mistress"): "Champ") + "?\"</i>\n\n");
			outputText("You motion for her to join you on the ground, and she tilts her head, taking a silken rope. She jumps down from the tree, holding the rope, and ties it off. She smiles, bow on her back. <i>\"What brings you to my section of camp?\"</i>\n\n");
			menu();
			addButton(0, "Appearance", LilyAppearance);
			addButton(1, "Talk", LilyTalk);
			if (player.lust >= 33) {
				if (player.gender > 0) addButton(2, "Sex", LilyFollowerSex);
				else addButtonDisabled(2, "Sex", "Not for genderless.");
			}
			else addButtonDisabled(2, "Sex", "Your lust is too low.");
			//addButton(3, "House", LilyHouse);
			addButton(4, "Spar", LilySpar);
			if (DriderTown.DriderTownComplete) addButton(13, "Back", SceneLib.dridertown.DriderTownEnter).hint("Return to main DriderTown menu.");
			addButton(14, "Leave", camp.campLoversMenu);
		}
		
		public function LilyFollowerSex():void {
			clearOutput();
			outputText("You give Lily a waggle of your eyebrows, before stepping in, grabbing the chain crossing her chest and pulling. Lily gives you a moan, but says nothing. Her body, however, is honest. Lily's cunt begins drooling almost immediately, and her back legs tap rapidly.\n\n");
			outputText("What do you want to do with your eager Drider-Slut, now that you have her?\n\n");
			menu();
			addButton(1, "Bondage", LilyBondage);
			addButton(2, "Roleplay", LilyRape);
			addButton(3, "3Some", Lily3Somes);
			addButton(4, "Back",LilyCampBack);
		}
		
		public function LilyCampBack():void {
			clearOutput();
			outputText("<i>\"Yes, [name], what did you need?\"</i>\n\n");
			menu();
			addButton(0, "Appearance", LilyAppearance);
			addButton(1, "Talk", LilyTalk);
			if (player.lust >= 33) {
				if (player.gender > 0) addButton(2, "Sex", LilyFollowerSex);
				else addButtonDisabled(2, "Sex", "Not for genderless.");
			}
			else addButtonDisabled(2, "Sex", "Your lust is too low.");
			//addButton(3, "House", LilyHouse);
			addButton(4, "Spar", LilySpar);
			if (DriderTown.DriderTownComplete) addButton(13, "Back", SceneLib.dridertown.DriderTownEnter).hint("Return to main DriderTown menu.");
			addButton(14, "Leave", camp.campLoversMenu);
		}
		
		public function LilyAppearance():void {
			clearOutput();
			outputText("Lily is a Drider, at first glance not that different from the others in the swamp. Her six eyes are violet, glowing slightly when it’s dark. Her dark lips shimmer, with twin fangs poking out from the upper lips. Her " + LilySkinTone + " skin is smooth, and her nakedness lets you see all of it, from her forehead down to her waist, where the supple skin smoothly transitions into shining black chitin. Her human hands transition into the same black chitin at her forearms, then back at her shoulders, almost like she’s wearing chitin bracers.\n\n");
			outputText("Below her slender neck, four E-cup breasts cover her chest, bound only by a set of fetishistic golden chains. Each of her nipples are pierced, with a thin rod of gold through each, keeping the chains in place. Hair flows down her scalp, falling in " + LilyHairColor + " waves past her shoulders, long enough to cover her top pair of E-Cups.\n\n");
			outputText("Her Spider-half has eight spindly legs, and her spinnerets are visibly active. Lily occasionally leans back, using her fingers to pull silk from her spinnerets, quickly braiding the strands into crude, yet serviceable rope.\n\n");
			outputText("As she sees you looking at her, Lily gives you a sly three-eyed wink, sliding a hand down her waist, making eye contact with you as she rubs her rapidly swelling ebony pussy lips with one hand.\n\n");
			doNext(LilyCampBack);
		}
		
		public function LilySpar():void {
			spriteSelect(SpriteDb.s_drider);
			clearOutput();
			outputText("You tell your kinky Drider to get her bow and follow you. Lily is slightly confused, but as you lead her just outside of camp, she smiles slightly.\n\n");
			outputText("\"<i>Oh, just like before, huh?</i>\" Lily stretches, drawing an arrow from her quiver. \"<i>I hope you’re prepared for what happens after~</i>\" Lily sinks into a shooter’s stance.\n\n");
			startCombat(new Lily());
		}
	}
}