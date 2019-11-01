/**
 * ...
 * @author Zakanard
 */
package classes.Scenes.NPCs 
{
import classes.*;
import classes.BodyParts.*;
import classes.BodyParts.Tail;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.API.Encounter;
import classes.Scenes.SceneLib;
import classes.display.SpriteDb;
import classes.internals.*;

	public class AikoScene extends BaseContent implements Encounter, TimeAwareInterface
	{
		
		public function AikoScene() 
		{
			EventParser.timeAwareClassAdd(this);//CoC.
		}
	
	//The source document for this encounter can be found at:
	//https://docs.google.com/document/d/1YMlyGPrf_Ejj_46-P-b945jZYX9oONkTS877mvBGX90/edit

	/*FLAGS RELATING TO AIKO AND YAMATA*/
	//public static const AIKO_TIMES_MET:int 			= 2353	//1=first, 2=second 3=third, 4+=fourth
	//public static const AIKO_CORRUPTION:int 			= 2354	//corruption score /100
	//public static const AIKO_CORRUPTION_ACTIVE:int	= 2355	//0=off, 1=on (corruption can be switched on by preference when you meet her and toggled from e4+)
	//public static const AIKO_AFFECTION:int 			= 2356	//affection score  /100
	//public static const AIKO_SEXED:int 				= 2357	//times sexed Aiko
	//public static const AIKO_BALL_RETURNED:int 		= 2358	//1=returned ball 2=didnt return ball (lock out Aiko encounters)
	//public static const AIKO_FIRST_CHOICE:int			= 2359	//1=riches, 2=power, 3=sex, 4=nothing, 5=fight, 6=touchFluffTail
	//public static const AIKO_FIRST_SEX_COOLDOWN:int	= 2360	//cooldown period after first time sex prank
	//public static const AIKO_HAS_FOUGHT:int			= 2361	//has fought Aiko about ball
	//public static const AIKO_FIGHT_WON:int			= 2362	//1=won, 2=lost fight about ball
	//public static const AIKO_HOT_BLOOD:int			= 2363	//once off special encounter
	//public static const AIKO_APOLOGY_SINCERE:int 		= 2364	//1=sincere, 2=trick apologize for fighting
	//public static const AIKO_RAPE:int					= 2365	//1=raped Aiko in scene 2
	//public static const AIKO_TALK_CULTURE:int 		= 2366	//1=first time 2+=repeated times
	//public static const AIKO_TALK_AIKO:int			= 2367	//1=first time 2+=repeated times	
	//public static const AIKO_TALK_ARCHERY:int			= 2368	//1=first time 2+=repeated times	
	//public static const AIKO_BOSS_INTRO:int			= 2369	//1=Yamata scene introduction at lvl 24+ and Aiko 100 affection
	//public static const AIKO_BOSS_COMPLETE:int		= 2370	//1=Yamata is dead 2 Yamata is released
	//public static const AIKO_BOSS_OUTRO:int			= 2371	//
	//public static const YAMATA_MASOCHIST:int			= 2372	//counter increases to 100, if not defeated 	
	//public static const AIKO_SPAR_VICTORIES:int		= 2308;	//counter for sparring
	
private var talkAndSex:Boolean = false;
	
public function encounterChance():Number { return 0.35; }
public function encounterName():String { return "aiko"; }
public function execEncounter():void { encounterAiko(); }
	
//Encounter Aiko
public function encounterAiko():void {
	EventParser.timeAwareClassAdd(this);	
	clearOutput();
	outputText(images.showImage("aiko-intro"));
	spriteSelect(SpriteDb.s_aiko);
	talkAndSex = false
	if (flags[kFLAGS.AIKO_TIMES_MET] == 0) {
		flags[kFLAGS.AIKO_AFFECTION] = 50;
	}
	
	//Count meetings
	flags[kFLAGS.AIKO_TIMES_MET]++;
	
	outputText(images.showImage("Aiko-intro"));
	//First encounter with Aiko
	if (flags[kFLAGS.AIKO_TIMES_MET] == 1) {
		outputText("As you walk deeper into the forest, it feels as though the dense foliage is creeping in even closer, while the thick canopy of leaves overhead threatens to blot out your view of the sky. By what little light manages to filter down through the trees, you can see that the rough-hewn dirt path you have been following dwindles down to almost nothing ahead, in the late stages of being reclaimed by the untamed wilderness. \n\n"
		+"Wherever you are, you are certain that you have never explored here before, and while you are mindful of this land’s dangers, you are curious what secrets this part of the forest might hold. You press on, trudging through the weed-choked trail, doing your best to keep your wits about you as you march onwards into the darkness. \n\n"
		+"Just as you are considering turning back, you see a faint light coming from somewhere up ahead. Stumbling through the undergrowth, you locate the source of the light—in front of you stands a massive, ancient-looking tree, with little wisps of blue flame dancing among the leaves, and an old, weathered sign hanging at the base. The writing on the sign is peeling and faded, but what few characters remain legible appear to be written in a strange language anyway. \n\n"
		+"You turn around, ready to go back the way you came, only to find that the trail that led you here has disappeared! You give an involuntary shudder as you hear the sound of ghostly feminine laughter echoing through the forest, sounding as though it is coming from all around you. \n\n"
		+"Running into the undergrowth, you search for the path, but suddenly find yourself stumbling back out into the clearing once again. Wondering how you could have been turned around so badly, you march back into the forest, wandering around for a few more minutes before emerging into a clearing again, stopping in your tracks as the same ghostly tree looms in front of you once more.\n\n"
		+"One of the pale flames breaks from the group, gently wafting down to float in front of your face. It dances about your arms, sending a cool tingling sensation across your limbs, and then flies away, disappearing behind the trunk of the tree. You follow it, chasing it around the tree, but trip on one of the exposed roots. As you stand, rubbing your jaw tenderly, you notice a small, featureless white ball resting in a cavity in the tree, and curiously reach out to grab it. \n\n"
		+"The clearing is suddenly bathed in a brilliant flash, forcing you to shield your eyes. When you open them again, you are greeted with the sight of something monstrously huge emerging from the underbrush, far too large to have been hiding there. A giant! You can’t be sure, but you estimate that it must be at least fifty feet tall, and it is clad in brightly-colored metal armor from head to toe.\n\n"
		+"You ready your [weapon], wondering how you could possibly fight something so huge, as the giant locks its glowing green eyes onto you. It raises its enormous armored foot, and you close your eyes, using the last few moments you have left to reflect on your life before being crushed beneath this impossible being’s heel.\n\n"
		+"When the impending death never arrives, you open your eyes, and shuffle back a bit in surprise, as standing before you now is not a 50-foot armored monstrosity, but a beautiful woman with a short mane of silver-blonde hair, parted by a pair of large triangular ears. She is dressed in a set of revealing blue and white robes that show off her girlish curves, her breasts squashed tightly into a cloth chest wrap. The pale blue flames dance around her, casting an eerie light across her features, and you can see that she has some red markings on her face, her lips curled into a perpetual smirk. Behind her, a group of seven luxuriously fluffy fox tails sways to and fro in time with an unheard melody. \n\n"
		+"<i>“You should have seen the look on your face!”</i> she says, laughing at you. <i>“You actually thought you were going to be crushed, didn’t you?”</i>\n\n"
		+"You find yourself at a loss for words, your mouth hanging agape. \n\n"
		+"Giggling lightly, the fox-eared woman walks up to you, pushing your lower jaw up with her index finger and walking around you, as if sizing you up. <i>“Hmm...It’s been a long time since I’ve seen a newcomer around here,”</i> she said, nodding slowly to herself. <i>“You must be the one that everyone has been talking about.”</i>\n\n"
		+"Everyone? What is she talking about? Finally, you come to your senses and ask her who she is, and what just happened to the giant. \n\n");
		if (player.kitsuneScore() >= 6 && player.tailType == 13) {
			if (player.tailCount == 9) {
				outputText("<i>“I am Aiko, guardian of these woo...”</i> she suddenly stops and wides her eyes, noting the swishy wheel of nine tails behind you. Gritting her teeth, she immediately falls on her knees, biting her lower lip much to your confusion. <i>“Please accept my deepest apologies! I... I didn't think you were nine-tails, my "+ player.mf("lord", "lady") +"! I'm so sorry!”</i>\n\n"
				+"Confused, you rub your fingers into your [hair], speechless. After some time, your recall Ayane's description of nine-tailed kitsunes, you are supposed to be nobility into the kitsune race, but you give a playful smile and tell her to not worry about that since it's your first meeting, offering her a hand.\n\n"
				+"Embarrassed, she lower her ears in shame and accepts your help, moving nervously her seven swishy tails. <i>“I-I just can't resist playing with newcomers, but since you fell into my prank, I thought you were some kind of illusionist with your tails!”</i> Giving a very nervous laugh, she successfully tries to mask her embarrassed blush. <i>“My name is Aiko, the guardian of these woods. My village didn't inform me that a nine-tails was on their way to visit us.. can I ask yours, my "+ player.mf("lord", "lady") +"”</i>\n\n"
				+"You calmly give her your name, she's a very interesting fellow, and at least she's not trying to rape you like half of Mareth. You add that you only recently became a nine-tailed kitsune and you are still learning about their culture, telling her she shouldn't be so formal."
				+"\n\n<i>“"+ player.mf("Lord", "Lady") +" [name]... no... [name]...It can be a bit sudden.. but can I ask you my ball back, please? You know how important is for us, probably you have one of your own, too.”</i> She seems much more relaxed after you told her to not worry about formalities.\n\n"
				+"<i>“Even if I'm strong, I don't know if I can match the power of a High "+ player.mf("Priest", "Priestess") +" of our god... but if I have to, I can get pretty rough... So tell me, [name], do I have to get rough?”</i>");
			}
			else  {
				outputText("<i>“I am Aiko, guardian of these woods. I see that you are one of my kind, but you are not from my village. So, are other clans still unaffected by the corruption?”</i>\n\n"
				+"Calmly, you explain that you only recently have become a kitsune via the magic that lurks in Mareth. She gives a playful nod and laughs slightly. <i>“I just can't resist, it was so easy to trick you, you need to improve if you want to be a full-fledged kitsune!”</i> she says with a playful grin, you can't help to be a bit embarrassed for this.\n\n"
				+"<i>“Anyhow, what's your name, fellow kitsune? We don't often get visitors since the Demons came.”</i> she asks, folding her arms under her large jiggling breasts.\n\n"
				+"You give her your name, somewhat relieved to find another resident of this world that is interested in more than beating you into submission and raping you—at least, so far."
				+"\n\n<i>“[name], huh? Well, [name], would it be terribly too much trouble for you to give me back my Ball? You know how important is for us since you're my kind.”</i> You know how important the sphere is for a kitsune, but before you can make the decision, she cuts you off <i>“Of course, I'm not afraid to get rough when I need to. So tell me, [name], do I have to get rough?”</i>");
			}
		}
		else {
			outputText("<i>“I am Aiko, guardian of these woods. You’re trespassing in kitsune territory. Didn’t you see the sign?”</i>\n\n"
			+"You explain to her that you couldn’t read the sign, but even when you tried to leave, you ended up getting turned around again and again.\n\n"
			+"<i>“Oh. Right…”</i> Aiko says, making a show of trying to look innocent. <i>“What can I say, I just couldn’t resist! Like I said, you’re the first newcomer I’ve seen in quite some time. There’s only so much amusement to be found when your only company is a tree. So then, newcomer, I’ve given you my name, why don’t you tell me yours?”</i>\n\n"
			+"You give her your name, somewhat relieved to find another resident of this world that is interested in more than beating you into submission and raping you—at least so far.\n\n<i>“[name], huh? Well, [name], would it be terribly too much trouble for you to give me back my Ball?”</i> she says, pointing to the white ball in your hand. Wary of simply taking anything at face value, you ask her why it’s so important to her, and what exactly she’s guarding all the way out here in the wilderness."
			+" As the chosen guardian of my clan, it’s my duty to protect these woods, and all the kitsune who reside in it,”</i> she explains, gesturing around. <i>“It’s not as glamorous as it all sounds,”</i> she assures you, <i>“I mostly just use my illusions to scare off imps and other demonic vermin. And tourists. Like you!”</i>"
			+"You are a little irritated about being called a “tourist” of all things,"
			+(player.cor>20?"and tell her as much with a slight scowl,":"") + " but you nod your head " + (player.cor<=20?"politely":"")
			+", now understanding that the giant was merely an illusion cast by this girl.\n\n"
			+"<i>“Of course, I’m not afraid to get rough when I have to. So tell me, [name], do I have to get rough?”</i>");
		}
		
		//[Yes][No]
		menu();
		addButton(0, "Yes", aikoAggroGreeting).hint("I want to keep this ball!");
		addButton(1, "No", aikoPeaceGreeeting).hint("Don't want to fight this cute fox-girl.");
	}
	// Once off silly mode encounter
	else if (flags[kFLAGS.AIKO_HOT_BLOOD] == 0 && flags[kFLAGS.AIKO_TIMES_MET]>3 && silly() && (flags[kFLAGS.AIKO_CORRUPTION] < 50 || flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==0) && rand(15)==0) {
		outputText("As you are walking a familiar-looking weed-choked trail in the deeper regions of the forest, you suddenly stop where you are, raising a hand to your ear. It’s faint, but you can hear the sounds of battle echoing through the trees.\n\n"
		+"Readying your [weapon], you decide to investigate. The sound leads you to the clearing where the ancient tree stands, and you have to duck in order to avoid being hit by a scorching missile of blue flame as you emerge from the underbrush.\n\n"
		+"Dominating the clearing is the largest tentacle beast you’ve ever seen! It must be ten times the size of the ones you’ve seen ambling about the woods, but thankfully it seems to be focused elsewhere. Aiko is locked in battle with the overgrown abomination, firing arrow after arrow into its leafy flesh, dodging between its fearsome tentacles and taking every opportunity to launch a flaming missile at it.\n\n"
		+"The blue projectiles explode on impact, staggering the beast long enough for Aiko to wind up for the finishing blow. Before your eyes, her usual robes have become a long cape with a flaming skull emblazoned on it, her eyes covered in a strange pair of glasses with red lenses.\n\n"
		+"<i>“Don’t take me lightly! WHO THE HELL DO YOU THINK I AM!?”</i> she shouts, raising her arm to point toward the sky for some reason. Your expression turns to one of utter bewilderment as Aiko pulls a gigantic drill from thin air!\n\n"
		+"Somehow, the diminutive lass manages not only to hold the ridiculous contraption aloft, but actually launch herself headlong into the stunned tentacle beast! The drill becomes lodged in the shambling monstrosity, and suddenly it seems like the entire world has gone into slow motion. Time slows to a crawl as Aiko turns and begins to calmly stride away from the still-living creature, her new cape flared around her dramatically as she pulls off her sunglasses. Behind her, the giant tentacle beast is suddenly engulfed in an enormous explosion, a pillar of flames spiraling up into the air to scrape the clouds.\n\n"
		+"It’s a bit over the top, but you have to admit that the way she isn’t looking at it is kind of cool.\n\n"
		+"When the tentacle beast is little more than a heap of smoldering char, Aiko, still oblivious to your presence, begins to do a little victory dance.\n\n"
		+"<i>“Oh yeah, uh-huh, I’m bad, it’s my birthday!”</i> she chants as she throws pretense to the wind, moving her fists in a circle in front of her. She carries on like this for some time, shaking her rump and dancing around in more and more ridiculous ways the longer she goes undisturbed.\n\n"
		+"You are starting to wonder how much more absurd her showboating is going to get when you at last can’t withhold a chuckle, alerting Aiko to your presence. She freezes mid “pop-and-lock”, turning slowly to look at you, a look of utter horror and embarrassment on her face.\n\n"
		+"<i>“H-how long were you… I uh… I left the stove on BYE!!”</i>\n\n"
		+"Before you can say another word, she dashes off into the forest, trying to hide the deep crimson blush on her face.");
		flags[kFLAGS.AIKO_HOT_BLOOD]++;
		doNext(camp.returnToCampUseOneHour);
	}
	// Second encounter with Aiko
	else if (flags[kFLAGS.AIKO_TIMES_MET] == 2) {
		outputText("You have a vague sense of déjà vu as you explore deeper into the forest. You can’t place it, but you feel like you’ve been here before… even stranger still is the feeling that you’re being watched. Attempting to shrug it off, you keep on the trail, but the back of your neck continues to tingle with a nagging suspicion, and you begin to succumb to paranoia, looking over your shoulder nervously.\n\n"
		+"You nearly jump out of your [skin] as you hear the leaves of a nearby tree rustling, dropping into a defensive position, your [weapon] at the ready. A flash of silver cuts through your field of vision as something small and furry darts down from the branches and tears off through the forest.\n\n"
		+(player.dogScore() >= 4 ? "Your canine chase instinct overrides your previous sentiments of paranoia, and you dash headlong through" : "You hesitate at first, but then decide to give chase, dashing into") +" the bushes after it.\n\n"
		+"You emerge into a clearing dominated by a familiar, ancient-looking tree, just in time to see a small feral fox with lustrous silver fur. It stares at you, seeming to regard you with an air of "
		+(flags[kFLAGS.AIKO_AFFECTION] >= 55 ? "fondness" : (flags[kFLAGS.AIKO_AFFECTION] > 50 ? "familiarity" : "contempt"))
		+" beyond that of a simple beast. Realization finally dawns as you take note of the fox’s most striking features—its eyes are a beautiful crystal blue, and it has not one, but nine beautiful tails.\n\n"
		+"Before your eyes, Aiko takes her humanoid form, the silky fur giving way to bare flesh and comfortable clothes. With the transformation complete, she gently adjusts her robes, allowing them to hang neatly off her lovely, well-groomed feminine features.\n\n"
		+"<i>“I’m surprised you managed to find this place again,”</i> she says once she has completed her short ritual, "+(flags[kFLAGS.AIKO_HAS_FOUGHT] > 0 ? "smiling" : "glaring")+" at you.");
		if (flags[kFLAGS.AIKO_AFFECTION] >= 55)	{
			outputText("<i>“Pleasantly surprised,”</i> she adds, her expression turning soft and affectionate. "
			+(flags[kFLAGS.AIKO_FIRST_CHOICE] == 6 ? "<i>“I’ve actually been hoping you’d find your way back here…”</i>":"")
			+"\n\nShe starts to make her way toward you, swaying gently as she walks. <i>“I wanted to say thank you again for returning my Ball…"+ (flags[kFLAGS.AIKO_FIRST_CHOICE] == 6 ? " and especially… for the other things you did,”</i> she says with a slight blush" : "”</i> she says") +". <i>“Most people probably wouldn’t have been that nice.”</i>\n\n"
			+"You concede that she may have a point; out of all the myriad encounters you’ve had traveling this strange land, the vast majority of them were far from as civilized as this. Her tone starts to shift toward a more playful, rambunctious attitude, and she asks, <i>“So, what brings you back here?”</i>");
			//[Talk][Sex][Fight]--[Leave]
			menu();
			addButton(0, "Talk", aikoTalkE2).hint("Talk with the foxy girl.");
			addButton(1, "Sex", aikoSexE2).hint("Have some fun times with foxy Aiko!");
			addButton(4, "Fight", aikoFight).hint("Attack that fox bitch!");
			addButton(14, "Leave", leave).hint("Leave the clearing");
		}
		else if ((flags[kFLAGS.AIKO_AFFECTION] > 50)) {
			outputText("<i>“So, did you enjoy your ‘present’?”</i> she says with a snicker, barely suppressing a full-blown grin. You give her a flat look, mustering up your best deadpan, and reply that you’ve had better.\n\n"
			+"<i>“Oh, don’t be so serious,”</i> she retorts, sticking out her tongue at you and smirking. <i>“Just a little harmless fun, is all.”</i>\n\n"
			+"At your expense, you are quick to remind her, crossing your arms indignantly. "+ (flags[kFLAGS.AIKO_FIRST_CHOICE] == 3?"You have to admit, the sex was good—you just could have gone without the undesired side-effects.":"") +" You would like to pursue the subject of her trickery further, but Aiko quickly deflects the discussion before you get a chance to speak up.\n\n"
			+"<i>“So what brings you back here? I hope you’re not counting on another freebie, because I’ve moved my Ball to a new hiding spot. Though… maaaaybe if you ask nicely…”</i> She trails off, giving you a cutesy little smirk, hands clasped behind her back as she leans forward, giving you a nice view of her ample bosom.");
			//[Talk][Sex][Fight]--[Leave]
			menu();
			addButton(0, "Talk", aikoTalkE2).hint("Talk with the foxy girl.");
			addButton(1, "Sex", aikoSexE2).hint("Have some fun times with foxy Aiko!");
			addButton(4, "Fight", aikoFight).hint("Attack that fox bitch!");
			addButton(14, "Leave", leave).hint("Leave the clearing");
		} else {
			outputText("<i>“You’ve got some nerve showing your face around here,”</i> she says coldly, her bow appearing from thin air. <i>“I hope you weren’t counting on "+ (flags[kFLAGS.AIKO_FIGHT_WON] == 1? "another free pass " : "a free pass this time") +"; I’ve hidden my Ball somewhere else now, so there’s no chance of you taking it hostage again.”</i>\n\n"
			+""+ (player.cor >= 50 ? "There she goes about that stupid ball again.":"") +"" + (flags[kFLAGS.AIKO_FIGHT_WON] ? "You tell her that she seems pretty high and mighty for someone who lost so handily the last time." +(silly() ? "Maybe, you suggest, she should check herself, before—and you quote—she wrecks herself.":"") : "She seems pretty confident that she can take you again, after her previous victory.") +" You can practically feel the daggers emanating from her eyes as she stares you down unflinchingly, looking like she’s almost itching for you to give her a reason to release her grip on the arrow pointed at you.\n\n"
			+(flags[kFLAGS.AIKO_FIGHT_WON] ? "<i>“It’s your move.”</i>": "<i>“So, are you going to leave peacefully, or do we do it the hard way again?”</i>"));
			//[Apologize][Sex][Fight][Leave]
			menu();
			addButton(0, "Apologize", aikoApologize1).hint("Apologize to Aiko for fighting her.");
			addButton(1, "Sex", aikoSexE2).hint("Have some fun times with foxy Aiko!");
			addButton(2, "Fight", aikoFight).hint("Attack that fox bitch!");
			addButton(3, "Leave", leave).hint("Leave the clearing");
		}
	}
	// Third encounter with Aiko
	else if (flags[kFLAGS.AIKO_TIMES_MET] == 3) {
		outputText("You walk out into the familiar clearing where the Ancient Tree stands, and you spot the kitsune priestess Aiko practicing with her bow. She hasn’t noticed your approach yet, drawing a new arrow from her quiver and sending a shot arcing through the air. You can see that her targets appear to be several squares of parchment tacked to the tree trunks, and with a squint you recognize that the closest one appears to bear a crude drawing of " +(flags[kFLAGS.AIKO_AFFECTION] >= 50 ? "a minotaur" : "you!")+"\n\n"
		+"Her arrows thud into the targets one after another, maintaining a beautifully dense grouping."+ (!player.hasStatusEffect(StatusEffects.Kelt) ? "She’s quite good!" : (player.statusEffectv1(StatusEffects.Kelt) < 75 ? "She’s quite good, though perhaps not as good as Kelt. Still, you might stand to learn a thing or two from her, and she’s probably better company than the arrogant centaur." : "She’s quite good, but not as good as Kelt or yourself. She might make a decent practice partner, but you probably wouldn’t learn anything new from her."))+"\n\n"
		+"Finally, you clear your throat, and she whips around, the arrow she was about to fire now trained on you instead! "+ (flags[kFLAGS.AIKO_AFFECTION] >= 50 ? "She relaxes when she recognizes you, letting the draw on her bow out slowly and lowering the weapon away from your chest." : "She snarls with disgust when she sees it’s you, keeping the weapon trained on you the entire time.")
		+"\n\n");
		if (flags[kFLAGS.AIKO_AFFECTION] >= 50)	{
			outputText("<i>“Oh, [name]! I was just practicing… Sorry about the uh, arrow,”</i> she says, tapping the shaft of the arrow up against her bow lightly. <i>“You startled me, is all.”</i>\n\n"
			+"You tell her it’s fine, and you understand—one never can be too careful.\n\n");
			if (flags[kFLAGS.AIKO_RAPE] < 1) {
				outputText("She smiles, dismissing her bow and walking toward you happily. "+ (flags[kFLAGS.AIKO_AFFECTION] >= 65 ? "With a big grin, she wraps her arms around your shoulders and gives you a kiss on the cheek, then backs up to talk to you.":"") +"\n\n<i>“What brings you back out here again?”</i>");
				//[Talk][Sex][Fight][Leave]
				menu();
				addButton(0, "Talk", aikoTalkE3).hint("Talk with the foxy girl.");
				addButton(1, "Sex", aikoSex).hint("Have some fun times with foxy Aiko!");
				addButton(3, "Spar", aikoSpar).hint("Exchange some friendly blows.");
				addButton(4, "Fight", aikoFight).hint("Attack that fox bitch!").disableIf(player.cor <= 40, "You are not corrupt enough to just attack her out of the blue.");
				addButton(14, "Leave", leave).hint("Leave the clearing");
			} else {
				outputText("She nods, but seems to shrink back from you uneasily. You notice she hasn’t dismissed her bow yet, even though it isn’t pointed at you anymore.\n\n"
				+"<i>“You… you’re not gonna try to rape me again, are you?”</i> she says, looking at you hopefully. "+ (player.cor <= 50 ? "Her question stings your conscience a little, and it’s made only worse by her innocent expression. She dearly wants to like you—you can see it in her eyes.":"") +"\n\n"
				+"Well, what are you going to do?");
				//[Talk][Sex][Both][Spar][Fight]--[Leave]
				menu();
				addButton(0, "Talk", aikoTalkE3).hint("Talk with the foxy girl.");
				addButton(1, "Sex", aikoSex).hint("Have some fun times with foxy Aiko!");
				addButton(4, "Fight", aikoFight).hint("Attack that fox bitch!").disableIf(player.cor <= 60, "You are not corrupt enough to just attack her out of the blue.");
				addButton(14, "Leave", leave).hint("Leave the clearing");
			}
		} else {
			outputText("<i>“You just won’t take a hint, will you?!”</i> she growls, narrowing her eyes.\n\n"
			+"<i>“What the hell are you doing back here?”</i>");
			//[Talk][Sex][Fight][Leave]
			menu();
			addButton(0, "Talk", aikoTalkE3).hint("Talk with the foxy girl.");
			addButton(1, "Sex", aikoSex).hint("Have some fun times with foxy Aiko!");
			addButton(2, "Fight", aikoFight).hint("Attack that fox bitch!");
			addButton(14, "Leave", leave).hint("Leave the clearing");
		}
	}
	else if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0 && flags[kFLAGS.AIKO_BOSS_OUTRO] == 0) {
		outputText("As you make your way into the bioluminescent deepwoods, you remember you had a discussion to do with Aiko, she was "+(flags[kFLAGS.AIKO_BOSS_COMPLETE] == 1 ? "really glad the nightmare was over":"really angry you let her sister go")+".\n\n"
		+"You move across the bushes and you notice a familiar presence. You lean your back on a tree as you see a blue flame moving towards you. Immediately after that, the flame explodes and Aiko materializes in front of you. "+(flags[kFLAGS.AIKO_BOSS_COMPLETE] == 1 ?"She's very happy to see you":"She looks bittersweet.")+"\n\n"
		+"<i>“Hey, [name]... I... I want to thank you again for your help down there... I'm a failure as a guardian, it was my duty to prevent Yamata from getting to the village but I was outsmarted... Don't worry, I'm not letting it happen again. Look here.”</i> She solemnly states as she extends her tails. With a hint of surprise, you notice she has one more.\n\n"
		+"You smile and congratulate the now eight-tails as she tries to hide a deep crimson blush on her face. She seems to be really convinced to become a nine tails and you are very happy that she is making it a reality. You spend the remaining time happily chatting with your kitsune girl.\n\n"
		+"<i>“See you around, [name].”</i> She lets you go after a quick peck on the cheek. As you see her rush away, you notice she still has Yamata's Muramasa katana tied to her hip. That blade is as strong as ever, but it seems that Aiko is as yet unaffected. Her magic has however grown very strong indeed. Still, you are worried, you better keep an eye on her state from now on, lest she become corrupted like her half-sister.");
		flags[kFLAGS.AIKO_BOSS_OUTRO] = 1;
		doNext(camp.returnToCampUseOneHour);
	}
	else if (flags[kFLAGS.AIKO_BOSS_COMPLETE] ==0 && player.level >= 25 && flags[kFLAGS.AIKO_AFFECTION] > 90 && flags[kFLAGS.AIKO_TIMES_MET] > 3) {
		if (flags[kFLAGS.AIKO_BOSS_INTRO] > 0) {
			if (flags[kFLAGS.AIKO_CORRUPTION] < 50 || flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==0) {
				outputText("As you return to the Ancient Tree, you call out to Aiko. You spot her sitting at the base of the tree, with her arms around her knees. It looks like she hasn’t moved from that spot for quite some time, and the redness of her cheeks suggests she has been crying again. She looks up hopefully when you approach and asks, <i>“[name], you’re back! Please tell me you’re ready to go now…”</i>");
				//[Go Now][Prepare]
				menu();
				addButton(0, "Talk", yamataTalk).hint("Ask Aiko for more info on Yamata.");
				addButton(1, "Go Now", yamataStart).hint("Go with Aiko to take on Yamata and stop her madness!");
				addButton(2, "Prepare", yamataPrepare).hint("Go home and prepare, this will be a very tough fight!");
			} else {
				outputText("As you enter the clearing of the Ancient Tree, you call out to Aiko. By the look of things, she has been angrily hacking up the bark at the base of the tree again, and the tree has not been taking it well. Its foliage has started to decay, and it’s obvious that it’s on its last legs. It probably will not survive the abuse. <i>“It’s about time! You better be ready to go.”</i>\n\n"
				+"If you feel like you’re ready to face Aiko’s half-sister, you could go now, or you could tell her you still need time to prepare. Maybe you could press her for a little more information, just to be sure.");
				//[Go Now][Prepare]
				menu();
				addButton(0, "Talk", yamataTalk).hint("Ask Aiko for more info on Yamata.");
				addButton(1, "Go Now", yamataStart).hint("Go with Aiko to take on Yamata and stop her madness!");
				addButton(2, "Prepare", yamataPrepare).hint("Go home and prepare, this will be a very tough fight!");
			}
		}
		else if (flags[kFLAGS.AIKO_CORRUPTION] < 50 || flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==0) {
			outputText("As you enter the familiar clearing looking for Aiko, you hear the faint sounds of sobbing. Curiously, you round the trunk of the tree to find Aiko slumped up against it on her knees, weeping uncontrollably into her sleeve. Taking her by the shoulders, you ask her what’s wrong, and she looks up at you with her teary, crystal blue eyes, wiping her face on her robes to try to make herself look more presentable.\n\n"
			+"<i>“[name], it’s... it’s my Ball! I-I don’t know how s-she found it, b-but...”</i>\n\n"
			+"You grip her shoulders tightly and tell her to calm down and get a hold of herself, and she nods, drawing in a deep breath to try and control her blubbering enough to string together a coherent sentence.\n\n"
			+"<i>“M-my sister, Yamata... well, half-sister... she... she found my Ball.”</i>\n\n"
			+"You loosen your grip a little, and ask why it’s such a big deal that another kitsune found her ball.\n\n"
			+"<i>“It’s a huge deal!”</i> she says, almost slipping into hysterics again, biting her lip and squeezing a few more tears out before calming down. <i>“She was exiled from the village years ago... but... I never expected... [name], she’s been corrupted!”</i>\n\n"
			+"You nod, understanding now.\n\n"
			+"<i>“She’s already drained most of my power from it... every minute that goes by I can feel my link to it fading more... I’ve.... I’ve failed... She’s gone ahead into the village already... who knows what kind of things she’s doing to everyone... I’ve failed as a protector,”</i> she says, dropping to almost a whisper, clutching her head in despair.\n\n"
			+"Nonsense! You pick her back up and hold her tightly, telling her that it will be alright. She whimpers, clutching to your shoulder and letting her tears flow. <i>“I... I can’t do it alone... Maybe if I still had my powers... but she’s too strong for me now. She’s a monster. Please... help me...”</i>\n\n"
			+"She looks up into your eyes, blinking away her tears. There’s no doubt about it, Aiko needs your help... but this Yamata sounds like she might be frighteningly strong. It might be a good idea to take some time to prepare first. \n\nWhat will you do?");
			flags[kFLAGS.AIKO_BOSS_INTRO]++;
			//[Go Now][Prepare]
			menu();
			addButton(0, "Go Now", yamataStart).hint("Go with Aiko to take on Yamata and stop her madness!");
			addButton(1, "Prepare", yamataPrepare).hint("Go home and prepare, this will be a very tough fight!");
		} else {
			outputText("As you enter the clearing, you happen upon Aiko hacking away at the side of the Ancient Tree with her bill-hook and unleashing a constant stream of obscenities so foul it makes your ears burn. Wary of getting too close to her in such a mood, you instead call out to her, asking what has her in such a huff. She whips around with an animalistic rage in her eyes and chucks her bill-hook toward you in a fit of anger. The twisted hatchet scythes through the air, curving away from you and sticking fast into the side of a tree behind you.\n\n"
			+"<i>“Don’t sneak up on me!”</i> she yells, seething visibly. She growls and gasps heavily for several moments before finally reigning in her heated temper. <i>“It’s... my fucking bitch of a half-sister, Yamata. She came here, and would you like to know what she had? MY BALL!”</i>\n\n"
			+"You ask what the big deal is, if it was another kitsune that found it.\n\n"
			+"<i>“It’s a BIG FUCKIN’ DEAL!”</i> she snarls, snapping her fingers. Her bill-hook wobbles a bit in its place, but stays where it is, refusing to return to her hand. <i>“She drained my magic, and she’s using it to fuck up my village now! I could care less what happens to them, but I WANT MY BALL BACK!”</i>\n\n"
			+"She puts a hand up to her face, trying her best to calm down. <i>“I can feel my link with it fading every passing minute... As much as I hate it... I need... help. Don’t look so smug! I’m asking you because you’re the only one I can come to who might stand a chance of getting it back for me!”</i>\n\n"
			+"You cross your arms, asking her why she can’t just get the ball back herself.\n\n"
			+"<i>“I told you! She drained my powers! She was already strong to begin with, and now, she’s practically a demon! Look, I don’t like it any more than you do, but you’re the only one I can count on, so are you gonna help me or not?”</i>\n\n"
			+"Well, there’s no doubt in your mind that she wouldn’t be asking you like this if she wasn’t really desperate. This Yamata sounds like she might be a strong opponent, though. It might be wise to take some time to prepare first. What will you do?")
			flags[kFLAGS.AIKO_BOSS_INTRO]++;
			//[Go Now][Prepare]
			menu();
			addButton(0, "Go Now", yamataStart).hint("Go with Aiko to take on Yamata and stop her madness!");
			addButton(1, "Prepare", yamataPrepare).hint("Go home and prepare, this will be a very tough fight!");
		}
	} else {
		//encounters from 4th and on
		outputText("You enter the clearing where the Ancient Tree stands, calling out for Aiko.\n\n");
		var temp:int;
		if (flags[kFLAGS.AIKO_CORRUPTION] < 50 || flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==0) {
			if (flags[kFLAGS.AIKO_AFFECTION] >= 50) {
				temp = (flags[kFLAGS.AIKO_AFFECTION] >= 50? rand(3) : rand(2)+1);
				if (temp == 0) //33% chance if affection > 50
					outputText("<i>“DYNAMIC ENTRY!”</i>\n\n"
					+"Before you can react, you feel Aiko’s thighs suddenly slam down on your shoulders as she seems to drop out of nowhere. "+ (player.str > 60 ? "The impact startles you, but you maintain your balance and help her down to the ground." : (player.str >= 30 ?"The impact knocks the wind out of you, but thankfully Aiko is pretty light, and you manage to get her to the ground safely." : "You buckle under the force of the impact, and wind up on your face with Aiko sitting on your back. <i>“Heheh, oops. Sorry!”</i> she says as she helps you up.")) +"\n\n");
				if (temp == 1) //33% chance if affection > 50 else 50%
					outputText("After a minute or two, the cute kitsune priestess emerges from the forest, her bow slung over her shoulder. She has a few patches of dirt on her forehead, and it looks like she’s been out hunting small game. Pleased to see you, she goes to freshen up and returns a few minutes later, looking pristine as always.\n\n");
				if (temp == 2) //33% chance if affection > 50 else 50%
					outputText("The branches of the trees rustle a little, and suddenly she swings down, hanging from her knees off one of the lower boughs. Grinning widely, she releases her grip and gracefully flips to the ground… only to fail to stick the landing and slip onto her plump derriere with a yelp! She picks herself up and brushes herself off, trying to pretend like nothing happened, but you can’t help but chuckle a little.\n\n");
				if (flags[kFLAGS.AIKO_AFFECTION] >= 75)
					outputText("She gives you a quick hug and a peck on the cheek in greeting. ");
				outputText((flags[kFLAGS.AIKO_CORRUPTION] <= 20 || flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==0? "She then walks over to the great tree and casually leans against it, her arms behind her back as she smiles at you cutely. She’s every bit as peppy and effervescent as always." : (flags[kFLAGS.AIKO_CORRUPTION] <= 40 ? "She then walks up to the tree, seeming a bit less energetic than usual. The old spark in her eyes has gone dull, but in its place there is a glimmer of something… else. You wonder if you’re starting to rub off on her a little." : "She has an odd sway in her step, and something about her just seems… off. You’re beginning to suspect that hanging around you has started to seriously affect her personality."))
				+"The whole clearing is bathed in a soft azure glow from the ethereal flames that dance through the branches.\n\n"
				+"<i>“Hi [name], what’s goin’ on?”</i>");
				//[Talk][Sex][Both][Spar][Fight]--[Leave]
				menu();
				addButton(0, "Talk", aikoTalk).hint("Talk with the foxy girl.");
				addButton(1, "Sex", aikoSex).hint("Have some fun times with foxy Aiko!");
				addButton(2, "Both", aikoTalkAndSex).hint("Have a chat and then some fun times with foxy Aiko after!");
				addButton(3, "Spar", aikoSpar).hint("Exchange some friendly blows.");
				addButton(4, "Fight", aikoFight).hint("Attack that fox bitch!").disableIf(player.cor <= 75, "You are not corrupt enough to just attack her out of the blue.");
				addButton(9, "Corruption "+(flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] ==0?"off":"on"), toggleCorruption).hint(flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] == 0 ? "Aiko's corruption is disabled":"Aiko's corruption is enabled");
				addButton(14, "Leave", leave).hint("Leave the clearing");
			} else {
				outputText("You have to duck when an arrow goes whizzing by your head, sticking into a tree behind you with a thud. Aiko marches out of the underbrush and pulls out another arrow, walking up to stand by the Ancient Tree. "+((flags[kFLAGS.AIKO_CORRUPTION] <= 20 || flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==0) ?"You can see that same spark of life and pride in her eyes as always." : (flags[kFLAGS.AIKO_CORRUPTION] <= 40 ? "The spark of pride and life is gone from her eyes, replaced with something colder. You have your suspicions that she has you to thank for that." : "She seems to have an unsettling sway in her gait, like she’s just a little off balance. There is a look in her eye that suggests her mind might be going slightly unhinged as well."))+" Ethereal blue flames dance around the clearing, casting everything in a pale, ghostly light.\n\n"
				+"<i>“That was a warning shot... What do you want?”</i>");
				//[Talk][Sex][Talk&Sex][Fight]--[Corruption]--[Leave]
				menu();
				addButton(0, "Talk", aikoTalk).hint("Talk with the foxy girl.");
				addButton(1, "Submit", submitToAiko).hint("Have some fun times with foxy Aiko!\nThough in her current state who knows what she'll get up to!");
				addButton(2, "Talk&Sex", aikoTalkAndSex).hint("Have a chat and then some fun times with foxy Aiko after!");
				addButton(3, "Fight4Rape", aikoFight).hint("She likes it when you try to rape her!");
				addButton(9, "Corruption "+(flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] ==0?"off":"on"), toggleCorruption).hint(flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] == 0 ? "Aiko's corruption is disabled":"Aiko's corruption is enabled");
				addButton(14, "Leave", leave).hint("Leave the clearing");
			}
		} else {
			temp = rand(3);
			if (temp == 0) //33% chance
				outputText("In no time, the deranged kitsune guardian appears from the forest, covered in fresh scrapes and bruises. It’s obvious from the bodily fluids matting down her hair that she has been out terrorizing the forest creatures again, and the pungent sexual aroma emanating for her tells you all you need to know about her conquests.");
			if (temp == 1) //33% chance
				outputText("The crazed priestess drags herself out of the underbrush, grinning maniacally. Judging by the nature of her wounds, you guess that she has been terrorizing Giant Bees, a thought further supported by the sticky golden residue that she is still licking off her forearms.");
			if (temp == 2) //33% chance
				outputText("A billhook scythes through the air, barely missing your head as it impacts a tree with a loud THUD!, making you duck in defense. Aiko emerges from the forest, letting out a depraved laugh as she eyes you like a vulture circling a carcass. She seems to gain a handle on her barely-restrained psychosis after a moment or two, but it’s obvious that she’s worked up over something.");
			if (flags[kFLAGS.AIKO_AFFECTION] >= 60)
				outputText("<i>“Back to play, sweetie? I’ve been looking forward to it…”</i> ");
			else outputText("<i>“Back again? You’d better not be wasting my time…”</i> ")
			outputText("She walks up to lean on the tree, her arms crossed under her breasts, watching you with a terrifying grin. Sickly purple flames wind their way through the branches, setting the entire clearing in an eerie lavender glow that seems to blot out all outside light. The smell of day-old musk permeates the air, and even the foliage in the surrounding area seems to be wilting with the stench of corruption.");
			//[Talk][Sex][Both][Spar][Fight]--[Leave]
			menu();
			addButton(0, "Talk", aikoTalk).hint("Talk with the foxy girl.");
			addButton(1, "Sex", aikoSex).hint("Have some fun times with foxy Aiko!");
			addButton(2, "Both", aikoTalkAndSex).hint("Have a chat and then some fun times with foxy Aiko after!");
			addButton(3, "Spar", aikoSpar).hint("Exchange some friendly blows.");
			addButton(4, "Fight", aikoFight).hint("Attack that fox bitch!");
			addButton(9, "Corruption "+(flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] ==0?"off":"on"), toggleCorruption).hint(flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] == 0 ? "Aiko's corruption is disabled":"Aiko's corruption is enabled");
			addButton(14, "Leave", leave).hint("Leave the clearing");
		}
	}
}
	
public function timeChange():Boolean
{
	if (player.hasStatusEffect(StatusEffects.AikoLustPrank)) {
		player.addStatusValue(StatusEffects.AikoLustPrank, 1, -1);
		if (player.statusEffectv1(StatusEffects.AikoLustPrank) <= 0) {
			player.removeStatusEffect(StatusEffects.AikoLustPrank);
			dynStats("sen", -15);
			outputText("The constant flush on your skin finally fades away as Aiko’s magic wears off. At last, you can finally move around freely again without getting turned on at the slightest touch!");
		}
	}
	return false;
}

public function timeChangeLarge():Boolean
{
	return false;
}

private function leave():void
{
	if (player.hasStatusEffect(StatusEffects.Spar)) {
		player.removeStatusEffect(StatusEffects.Spar);
		cleanupAfterCombat();
	}
	if (player.hasStatusEffect(StatusEffects.DomFight)) {
		player.removeStatusEffect(StatusEffects.DomFight);
		cleanupAfterCombat();
	}
	doNext(camp.returnToCampUseOneHour);
}

/////////////////////////////////////////////////////////////////////
//////////////////////AIKO CORRUPTION SETTINGS///////////////////////
private var initScene:String = "Peace";
private function initialCorruptionSetting():void {
	clearOutput();
	outputText("Aiko is a character with optional corruption scenes. Her corruption is disabled by default but can be enabled now or late in her encounters.\n\n"
	+"Do you wish to enable corruption for Aiko?\n\n");
	menu();
	addButton(0, "Enable corruption", aikoEnableCor).hint("Aiko's corruption will progress as normal and scenes may differ from pure.");
	addButton(1, "Disable corruption", aikoDisableCor).hint("Aiko's corruption will not progress and all pure scenes will be be used.");
}
private function aikoEnableCor():void {
	flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] = 1;
	outputText("Aiko's corruption has been enabled and will progress as normal with certain interactions.");
	if (initScene == "Aggro") doNext(aikoAggroGreeting);
	else doNext(aikoPeaceGreeeting);
}
private function aikoDisableCor():void {
	flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] = 0;
	outputText("Aiko's corruption has been disabled and will not progress regardless of interactions.");
	if (initScene == "Aggro") doNext(aikoAggroGreeting);
	else doNext(aikoPeaceGreeeting);
}
private function toggleCorruption():void {
	flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] ^= 1;
	flags[kFLAGS.AIKO_TIMES_MET]--;
	doNext(encounterAiko);
}

/////////////////////////////////////////////////////////////////////
///////////////////////////ONCE OFF SCENES///////////////////////////
private function aikoAggroGreeting():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You ask her if that was a threat, stowing the ball and readying your [weapon]. You’re certain that she’s trying to trick you somehow, and you won’t stand for it!\n\n"
	+"<i>“Heheh… well… you know, maybe I was hasty. Perhaps we could strike a deal? What do you say? My Ball in exchange for anything your heart desires. Riches, power… I could help take the edge off things, if you know what I mean,”</i> she says coyly, wiggling her hips seductively.\n\n"
	+"Whatever this ball is for, it seems like it is very important to her. Maybe you should reconsider—you could probably get her to do anything… but it might be a trick. What will you ask for?");
	initScene = "Aggro";
	//[Riches][Power][Sex][Nothing][Fight][TouchFluffTail]
	menu();
	addButton(0, "Riches", aikoE1Riches).hint("GIVE ME ALL THE GOLD!!!");
	addButton(1, "Power", aikoE1Power).hint("I can actually have more power?!!!");
	addButton(2, "Sex", aikoE1SexPart1).hint("That sexy proposition sounded very enticing...");
	addButton(3, "Nothing", aikoE1Nothing).hint("Give it back, it's hers' after all.");
	addButton(4, "Fight", aikoFight).hint("This ball is mine!");
	addButton(5, "Fluffy Tail", aikoTouchFluffTail).hint("Those tails look so fluffy... GOTTA TOUCH THEM!!!");
	addButton(9, "Corruption", initialCorruptionSetting).hint("Activate Aiko's Corruption");
}

private function aikoPeaceGreeeting():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("You wonder if you should take that as a threat for a moment, until Aiko lets out a snorting laugh. <i>“Nah, I’m just kidding. You seem legit. But seriously, gimme back my Ball.”</i>\n\n"
	+"You give her a hesitant grin, laughing along awkwardly. Just your luck—even if she isn’t overly aggressive, you can’t help but feel that Aiko has a few screws loose upstairs. Then again, perhaps this is normal for her kind?\n\n"
	+"<i>“Okay, listen up, I’ll tell you what. I like you, so I’m willing to make a deal with you. Besides, it was fun messing with you, so… What’ll it take to get my Ball back, hm? Riches? Power? Maybe a little… release?”</i> she says coyly, turning around and slapping her own plump, juicy rear playfully, revealing two spiral-shaped tattoos on her buttocks.\n\n"
	+"Whatever this ball is for, it seems like it is very important to her. You could probably get her to do just about anything… What will you ask for?");
	initScene = "Peace";
	//[Riches][Power][Sex][Nothing][TouchFluffTail]
	menu();
	addButton(0, "Riches", aikoE1Riches).hint("GIVE ME ALL THE GOLD!!!");
	addButton(1, "Power", aikoE1Power).hint("I can actually have more power?!!!");
	addButton(2, "Sex", aikoE1SexPart1).hint("That sexy proposition sounded very enticing...");
	addButton(3, "Nothing", aikoE1Nothing).hint("Give it back, it's hers' after all.");
	addButton(4, "Fluffy Tail", aikoTouchFluffTail).hint("Those tails look so fluffy... GOTTA TOUCH THEM!!!");
	addButton(9, "Corruption", initialCorruptionSetting).hint("Activate Aiko's Corruption");
}
	
private function aikoE1Riches():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("You consider her offer for a moment, and then tell her that you could always use a few extra gems.\n\n"
	+"<i>“Avaricious little scamp, aren’t you?”</i> Aiko teases, smirking. <i>“Alright, come with me,”</i>she says, beckoning you to follow her to the base of the tree. <i>“Wait right here,”</i> she tells you, before adding, <i>“And no peeking!”</i>\n\n"
	+"She gestures for you to turn around, and you consider protesting, but obey with a shrug when she shoots you a stern glance. You turn around when you hear her coughing, and find her standing there with a small wooden chest in her hand, waving her other hand to clear away a cloud of smoke that is rising from the chest."
	+"Aiko, with a grin, thrusts the chest into your hands, bouncing girlishly. At her behest, you open it, finding it filled to the brim with gems! Pleased with your transaction, you honor your end of the bargain, tossing the ball to her and bidding her farewell."
	+"<i>“Oh, don’t even mention it. My pleasure entirely,”</i> she says with a wink, and you can’t help but feel like she knows something you don’t. Shrugging it off, you make your way back to camp, your new bounty in tow…\n\n"
	+"Upon your return to camp, you set the chest down to count your newly-acquired riches, hearing a hollow thump! Wait, that’s not right. Wasn’t this chest a lot heavier just a little while ago? You open the chest hastily, and find that the contents have turned to a pile of leaves!\n\n"
	+"You’ve been had! It appears Aiko has gotten the better of you...\n\n");
	if (player.hasKeyItem("Camp - Chest") < 0) {
		player.createKeyItem("Camp - Chest", 0, 0, 0, 0);
		outputText("Well, maybe you could use the chest for storage… \n\n<b>You now have " + num2Text(inventory.itemStorageDirectGet().length) + " storage item slots at camp.</b>");
	} else {
		outputText("Before your eyes, the chest transforms into a white piece of paper with a cartoonish face drawn on it, blowing you the raspberry.");
	}
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	flags[kFLAGS.AIKO_FIRST_CHOICE] = 1;
	flags[kFLAGS.AIKO_AFFECTION]++;
	doNext(camp.returnToCampUseOneHour);
}

private function aikoE1Power():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("After a little thought, you tell her that a little more power could go a long way toward helping you on your quest.\n\n"
	+"<i>“Teehee… Alright "+ player.mf("Mr.","Mrs.") +" Hero, your wish is my command,”</i> Aiko teases, grinning mischievously. She thinks for a minute and then appears to be struck with inspiration, her face lighting up as she runs off, shouting to you, <i>”Stay right here! Don’t move!”</i>\n\n"
	+"You wait patiently, wondering just what she is up to. A minute passes, and Aiko returns with a bundle in her arms, holding it aloft as she runs toward you. <i>“Check it out! I wrapped it and everything! C’mon, open it!”</i> she shouts, handing you the long bundle, wrapped in a purple cloth and tied with gold cord.\n\n"
	+"You blink, a little taken aback by her enthusiasm, and begin to unwrap the bundle. As you pull the purple cloth away, you find that it contains a shining golden sword with runic symbols engraved in the blade.\n\n"
	+"<i>“It’s a sword! I found it in the woods!”</i> she exclaims, grinning widely. <i>“It’s magical though, check out the blade!”</i>\n\n"
	+"When you take the sword’s hilt into your hands, you feel the blade hum with magical energy. The engravings begin to glow, and the sword suddenly bursts into flames!\n\n"
	+"Once you figure out how to power the sword down, you wrap it back up and thank Aiko. Pleased with your transaction, you honor your end of the bargain, tossing the ball back to her and bidding her farewell.\n\n"
	+"<i>“Oh, don’t even mention it. My pleasure entirely,”</i> she says with a wink, and you can’t help but feel like she knows something you don’t. Shrugging it off, you make your way back to camp, your new bounty in tow…"
	+"…Upon your return to camp, you sit down to take a closer look at your new sword. You hastily unwrap the bundle, only to find that it has been replaced with a plain Lead Pipe! Attached to it is a small piece of paper with a cartoonish face drawn on it, blowing you the raspberry.\n\n"
	+"You’ve been had! It appears Aiko has gotten the better of you... Well, if you swing it hard enough, the pipe may still do some damage…");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	flags[kFLAGS.AIKO_FIRST_CHOICE] = 2;
	flags[kFLAGS.AIKO_AFFECTION]++;
	inventory.takeItem(weapons.PIPE, camp.returnToCampUseOneHour);
}

private function aikoE1SexPart1():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("You eye her lithe body up and down for a moment, licking your lips involuntarily as she slides her hands up and down her supple curves. A heat emanating from your loins tells you that your body has already made up your mind for you. You are about to give voice to your desires when Aiko saunters up to you, placing a finger to your lips and whispering, <i>“Shh… naughty "+ player.mf("boy" , "girl") +"… I can see you undressing me with your eyes. I know what you want.”</i>\n\n"
	+"Before you can say anything, she drops to her knees in front of you, pulling your [armor] aside to expose your groin.\n\n");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	flags[kFLAGS.AIKO_FIRST_CHOICE] = 3;
	if (player.hasCock() && player.hasVagina()) {
		outputText("She examines your loins for a moment and then looks up at you, saying, <i>“So, how would you prefer me to pleasure you, hm?”</i>");
		//[Male][Female]
		menu();
		addButton(0, "Male", aikoSexBJ).hint("Have her pleasure your dick with her mouth.");
		addButton(1, "Female", aikoSexCunni).hint("Let her explore the soft folds of your pussy with her tongue.");
	}
	else if (player.hasCock()) {
		doNext(aikoSexBJ);
	}
	else if (player.hasVagina()) {
		doNext(aikoSexCunni);
	} else {
		outputText("Seeing that you don't have any of the usual equipment she seems quite stumped. <i>“Uhmm I don't exactly know how you want me to please you if you don't have the right stuff...”</i>");
		doNext(aikoE1SexPart2);
	}
}
	
private function aikoE1SexPart2():void  {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("<i>“So… I don’t mean to be pushy, but…”</i>"
	+"You blink confusedly in your half-comatose state, and then are shaken back to reality as you remember your deal. Pleased with your <i>“transaction”</i>, you honor your end of the bargain, tossing her the ball."
	+"She smiles lightly, stowing it in her cleavage, and saunters off into the woods, swinging her hips to and fro. Before she disappears from sight, she turns with a knowing grin and says, <i>“Thanks for that, hon. Try not to get into too much trouble…”</i> You wonder what she meant by that, but can’t waste too much time thinking about it as you collapse on the ground in exhaustion from your lustful encounter."
	+"Once your body has recuperated, you gather your [armor] and make your way back to camp. On the way, you can’t help but notice that your entire body has become especially sensitive. Every step and movement makes you flush with arousal as your skin rubs against the inside of your clothes."
	+"Aiko’s magic has left you feeling extra sensitive! It will be hard to get along without becoming aroused in this state. Hopefully it will wear off soon…")
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	flags[kFLAGS.AIKO_AFFECTION] += 2;
	doNext(applyAikoLustPrankEffect);
}

private function applyAikoLustPrankEffect():void 
{
	player.createStatusEffect(StatusEffects.AikoLustPrank, rand(48)+24, 0, 0, 0);
	dynStats("sen", 35);
	doNext(camp.returnToCampUseOneHour);
}

private function aikoE1Nothing():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("You don’t know if it’s because you’re feeling charitable, or because of some nagging suspicion, but after some consideration, you decide to return her ball without asking for anything in return.\n\n"
	+"You hand it to her and tell her as much, watching her face light up with surprise as she reaches out to retrieve it from you.\n\n"
	+"<i>“You’re… serious? You’re just giving it to me?”</i> she says, taking it from you softly and stowing it in her cleavage. <i>“I… don’t know what to say. I mean, you have NO idea how grateful I am, but… honestly, I’m shocked.”</i>\n\n"
	+"She turns to walk away, but stops and puts her index fingers together on her lips, seeming to be deep in thought for a moment."
	+"<i>“Look… I don’t normally do this, but… you seem nice, and now I feel a little conflicted.”</i>\n\n"
	+"Strolling up to you, she grabs the back of your head and pulls you into a kiss before you can react. As she exhales into your mouth, you can taste wintergreen cascading over your tongue. When she pulls away, she gives you a smirk, and a little puff of blue flame escapes your lips.\n\n"
	+"<i>“Don’t get any ideas, now… I only did that to repay my debt, you hear me?”</i>\n\n"
	+"Despite her claims, she walks away with a clear smile on her face, her seven tails swishing to and fro as she disappears into the woods.\n\n"
	+"As you turn back toward camp, you still have the faint taste of wintergreen on your tongue, and you can’t help but feel a renewed vigor toward your quest.\n\n"
	+"Aiko’s fiery kiss has left your body and mind feeling invigorated!\n\n");
	player.dynStats("lus", 15, "cor", -5);
	var temp:int = rand(4);
	if (temp == 0) {
		outputText("You feel like you could arm-wrestle a minotaur, your muscles rippling with new reserves of strength!");
		player.dynStats("str", rand(4)+1);
	}
	if (temp == 1) {
		outputText("You feel like you could brush off a blow from even the strongest demon, your body feeling more resilient!");
		player.dynStats("tou", rand(4)+1);
	}
	if (temp == 2) {
		outputText("You feel like you could outrun a centaur, as you fill with newfound energy!");
		player.dynStats("spe", rand(4)+1);
	}
	if (temp == 3) {
		outputText("You feel like you could memorize an entire library’s worth of books, your mind becoming noticeably sharper!");
		player.dynStats("int", rand(4)+1);
	}
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	flags[kFLAGS.AIKO_FIRST_CHOICE] = 4;
	flags[kFLAGS.AIKO_AFFECTION] += 5;
	doNext(camp.returnToCampUseOneHour);
}

private function aikoTouchFluffTail():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("<i>“Wh-what?!”</i> Aiko shouts, a deep crimson blush on her cheeks.\n\n"
	+"You calmly repeat that you’d like to pet her fluffy tails, which only seems to deepen her blush.\n\n"
	+"<i>“O-oh… th-that’s what I thought you said,”</i> she says, trying to hide her blush with her hands, looking [if ("+"[tallness]"+"> 64)up|down] at you cutely between her fingers. <i>“W-well… I suppose… you could touch my tails… for just a little while…”</i>\n\n"
	+"You aren’t sure what about your request prompted such a drastic change in behavior from her, but the way she suddenly began acting so shy is quite cute. Aiko meekly strolls over to you, and politely instructs you to sit down, fidgeting apprehensively. You obey her request, lowering yourself down to the ground, and Aiko gently turns around, her many fluffy tails stroking along your body as she does so. She reaches back and pulls the bundle aside, which gives you a perfect line of sight to her gorgeous, voluptuous ass and the bright red spiral tattoos that adorn it, just before she daintily drops herself [if (!player.isBiped()|| player.tallness < 48)onto the ground next to you|into your lap].\n\n"
	+"<i>“O-okay… please be gentle… it’s my first time,”</i> she says, drawing the soft and bushy cluster of tails into her lap where you can reach them easily.\n\n"
	+"You have no idea what she’s talking about, but who cares, fluffy tails! Your hands move down to gently caress them, and a giddy grin crosses your lips as you begin to stroke each tail, feeling the luxurious softness tickle your palms as your fingers slide along the silvery fur. In your oblivious excitement, you barely register as Aiko’s head thuds heavily against your [if (!player.isBiped()|| player.tallness < 64)shoulder|chest]. You are entirely engrossed in how incredibly soft these tails are, gently sliding your hand from base to tip over and over again, even occasionally lifting one up to rub your cheek against it.\n\n"
	+"When you finally take a moment to look at Aiko, you are shocked to find her practically comatose, her eyes rolled back in pleasure and a thin trail of spittle dripping down her chin. <i>“nn… don’t stop…”</i> she whispers, gently sucking the spittle back into her mouth, her fingers softly clawing at your chest.\n\n"
	+"Understanding dawns on you now as you take her tails into your hands once more, running your fingertips through the fur and grinning a little. It seems Aiko is enjoying this a lot more than you would have thought! You can hardly complain, cradling the cute fox girl and her many tails in your arms and stroking them as you laugh lightly, one hand moving to gently scratch her ears."
	+"You continue to pet her for the better part of an hour, feeling as if the weight of this world’s corruption is being lifted from your shoulders. Finally, sadly, you tell her that you need to return and check up on your camp. Honoring your end of the bargain, you place her ball back into her hands and begin on your way.\n\n"
	+"<i>“…come back soon…”</i>");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	flags[kFLAGS.AIKO_FIRST_CHOICE] = 6;
	flags[kFLAGS.AIKO_AFFECTION] += 15;
	player.dynStats("lus", 10+rand(11), "cor", -5);
	doNext(camp.returnToCampUseOneHour);
}
		
internal function aikoLosesIntro():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("Aiko drops to one knee, panting heavily and supporting herself with her bow. Mustering up the last reserves of her willpower, she lines up one last arrow and releases it, but her strength is clearly spent—the arrow lobs through the air with all the grace of a drunken bumblebee, flying wide and clattering against the trunk of a tree.\n\n"
	+"<i>“You… you’re a lot stronger than I thought… I admit, I underestimated you...”</i> she says between breaths, collapsing as her longbow disappears out from under her.\n\n"
	+"<i>“Wha… what are you going to do?”</i>\n\n"
	+"That’s a good question. She’s at your mercy now, so you could do just about whatever you want to her. "+ (player.cor >= 40 ? "An evil smirk crosses your face as you think about teaching this little bitch a lesson for crossing you.":"") +"\n\n Will you rape her, and if so what will you do?");
	flags[kFLAGS.AIKO_FIGHT_WON] = 1;
	doNext(aikoRapeSex);
}

internal function aikoWinsIntro():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("You slump to the ground, [if (player.lust >= player.maxLust())crippled with desire|thoroughly thrashed], looking up at the fiery-eyed fox-woman.\n\n");
	if (flags[kFLAGS.AIKO_TIMES_MET] == 1) {
		if (player.kitsuneScore() > 0) {
			if (player.tail.type == Tail.FOX && player.tail.venom == 9) {
				outputText("<i>“... C-can it be? I... I defeated a nine-tails?”</i> With dismay painted across her face, she carefully makes her bow disappear in a puff of smoke. Surrounding herself with an array of fireballs, she approaches you and slowly reaches for your pouch, retrieving her white ball.\n\n"
				+"<i>“I'm... astonished... Maybe you let me win, but I just couldn't let you go with my ball.”</i>\n\n"
				+"She carefully tucks the ball into her cleavage, stepping back and keeping the fireballs pointed toward you at arm’s length. Holding her first two fingers up near her face, she whispers an incantation, and as the last syllables leave her lips, your vision begins to swim. Just before you black out, you can hear Aiko’s voice calling out as if from miles away."
				+"<i>“I'm sorry if I seem to be disrespectful.. but you pushed me.... and to think you were cute, too...”</i>");
			} else {
				outputText("<i>“I didn't want to do this, but you forced me”</i> she states while lowering her bow, allowing it to disappear in a puff of smoke. Keeping her guard up, she approaches you surrounding herself with fireballs. Cautiously she leans down and snatches the white ball from your pouch.\n\n"
				+"<i>“This ball is just too important for me to leave it in the hands of a stranger.”</i>\n\n"
				+"She carefully tucks the ball into her cleavage, stepping back and keeping the fireballs pointed toward you at arm’s length. Holding her first two fingers up near her face, she whispers an incantation, and as the last syllables leave her lips, your vision begins to swim. Just before you black out, you can hear Aiko’s voice calling out as if from miles away.\n\n"
				+"<i>“I'm sorry... you were kinda charming...”</i>");
			}
		} else {
			outputText("<i>“Just remember, you brought this on yourself,”</i> she says as she lowers her bow, allowing it to disappear in a puff of smoke. She keeps her eyes trained on you as she walks over, cautiously preparing a fireball in one hand, and reaches down to retrieve the white ball from your pouch.\n\n"
			+"<i>“I really never wanted to hurt you, I just needed this back.”</i>\n\n"
			+"She carefully tucks the ball into her cleavage, stepping back and keeping the fireball pointed toward you at arm’s length. Holding her first two fingers up near her face, she whispers an incantation, and as the last syllables leave her lips, your vision begins to swim. Just before you black out, you can hear Aiko’s voice calling out as if from miles away.\n\n"
			+"<i>“It’s too bad, you were kinda cute…”</i>\n\n"
			+"8 Hours Pass…"
			+"When you finally come to your senses, you find that you’ve been dumped at the edge of the forest, and there’s no sign of Aiko or the ancient-looking tree.");
		}
	} else {
		outputText("Aiko stands over you for a moment, murmuring an incantation under her breath, and you watch her point her first two fingers at your forehead just before the world goes dark.");
	}
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	cleanupAfterCombat();
}

private function aikoRequestsBallAfterLose():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("You turn away from the collapsed kitsune, ready to leave, but stop when you feel her hand clutching your [armor] desperately.\n\n"
	+"<i>“Wait! Please! I need... I need my Ball... Without it, my village...”</i>\n\n"
	+""+ (player.cor >= 40 ? "You angrily swat her hand away, glaring at the impertinent girl.":"") +" Your hand moves instinctively to the pouch where you stowed the white ball you found earlier. She seems to be truly desperate to get it back... Will you give it to her?");
	//[Give][Don't Give]
	menu();
	addButton(0, "Give", aikoLoseGiveBall).hint("Give her the damn ball already...");
	addButton(1, "Don't Give", aikoLoseRefuseBall).hint("She doesn't deserve to have it.");
}

private function aikoLoseGiveBall():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);		
	outputText("You look down at her pleading expression, "+ (player.cor >= 50 ? "and can’t help but get annoyed by the pitiful girl’s persistence":"and can’t help feel a twinge of remorse for the pitiful girl") +". Hesitantly, you reach into your pouch, pulling the ball out, and a small glimmer of hope shines in Aiko’s eyes at the sight of it.\n\n"
	+""+ (player.cor <= 50 ? "You place the ball in her hand, feeling a little sorry for what you’d done to the poor creature":"You drop the ball in front of her, spitting on it, hoping that will be enough to shut her up") +""
	+".\n\n<i>“Th... thank you...”</i> she whispers, clutching the ball to her chest. She drags herself to her feet and flees into the woods, only stopping to look back at you once.");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	flags[kFLAGS.AIKO_AFFECTION] += 2;
	cleanupAfterCombat();
}

private function aikoLoseRefuseBall():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText( ""+ (player.cor <= 50 ? "You pull away from Aiko’s grip and leave the clearing without a second glance, doing your best to ignore the sounds of her pleading cries.":"You plant your foot on her chest and give her a swift shove into the dirt, leaving the girl collapsed in a heap as you make your way out of the clearing.") +""
	+"\n\nOnce you have made it some distance from the clearing, you happen upon a stream that cuts through the woods. You reach into your pack and pull the white ball out, chucking it into the rushing waters and watching as it tumbles downstream."
	+"As you head back for camp, you have a feeling you won’t be seeing Aiko again anytime soon.");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 2;
	player.dynStats("cor", 5);
	cleanupAfterCombat();
}

/////////////////////////////////////////////////////////////////////
////////////////////////ENCOUNTER TWO////////////////////////////////
private function aikoTalkE2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You smile and tell her you’d just like to talk. She smiles back, suppressing a slight look of disappointment, and nods, saying, <i>“Oh, really? Well, I guess I could use the company.”</i>\n\n"
	+"She takes a seat on the grass, gesturing for you to do the same. <i>“Are you hungry?”</i> she asks, snapping her fingers and causing a small wooden box to appear in her hands with a puff of smoke. <i>“I don’t have much, but I’ll share with you.”</i>\n\n"
	+"You thank her for her offer, looking into the box as she opens it for you. Raw fish and cold rice? You’re not sure if that sounds very appetizing to you, "+ (player.cor <= 33 ? ""+ (flags[kFLAGS.AIKO_AFFECTION] >= 57 ? "but you don’t want to be impolite, so you carefully pick out a few pieces that look tasty and give her a smile. It’s surprisingly good, and she seems pleased that you liked it.":"but you don’t want to be impolite, so you carefully take a piece and put it in your mouth and... SPICY!! Aiko giggles at your unfortunate circumstances as you fan your mouth desperately to no avail, and you can’t help feeling she may have planned it from the start. At least she’s nice enough to offer you a drink.") +"":"so you give her a slightly disgusted look and push the box back over to her. She seems a little insulted, but doesn’t bring it up again.")+"\n\n"
	+"You regale her with tales of your adventures, and Aiko returns in kind with a few anecdotes about her life growing up in the kitsune village, and what it’s like to be its protector. The two of you talk for nearly an hour, but eventually you tell her that you should be going back to check on your camp soon."
	+"<i>“Okay,”</i> she says cheerfully, taking care of the cleanup with a snap of her fingers. <i>“Be sure to visit again soon!”</i>"
	+"You tell her you’ll certainly try, and wave to her as you set off.");
	flags[kFLAGS.AIKO_AFFECTION] += 3;
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==1) flags[kFLAGS.AIKO_CORRUPTION] -= 5;
	if (flags[kFLAGS.AIKO_CORRUPTION]<0) flags[kFLAGS.AIKO_CORRUPTION] = 0;
	doNext(camp.returnToCampUseOneHour);
}
	
private function aikoSexE2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You smile and ask if she’d be interested in a little <i>“roll in the grass.”</i>\n\n");
	if (flags[kFLAGS.AIKO_AFFECTION]>=55) {
		outputText("She smiles a bit in return, giggling at your forwardness.\n\n" 
		+"<i>“Oh [name], what kind of girl do you take me for?”</i> she teases, waving her hand nonchalantly. Seeing your slightly disappointed expression, she smiles and says, <i>“Relax, I’m only kidding... Truthfully, I could use a little stress relief.”</i>\n\n"
		+"She walks over to you and [if ("+"[tallness]"+" >64)standing on tiptoes,] gives you a peck on your cheek that leaves behind a light tingling sensation as she starts to help you out of your [armor] carefully.");
		aikoConsSex();
	}
	else if(flags[kFLAGS.AIKO_AFFECTION]>=50) {
		outputText("She gives you a big grin and says <i>“Straight to the point, huh? Well, at least you’re a "+player.mf("man", "woman")+" who knows what "+player.mf("he", "she")+" wants.”</i>\n\n"
		+"She stops for a moment and makes a big show of <i>“thinking about it,”</i> then finally puts a hand on her hip, letting one shoulder of her robe drop down, exposing the silky tan flesh to tease you. You can make a few guesses about what her final answer is as she saunters up to you and begins to help you out of your armorName, her seven tails swaying around hypnotically while she works.");
		aikoConsSex();
	} else {
		outputText("<i>“You’ve got to be kidding me. After what you did?!”</i>\n\n"
		+"She sneers at you, baring her sharp animalistic teeth angrily. <i>“Seriously, what are you, some kind of psycho? Get out of here, you unbelievable "+player.mf("bastard","bitch")+"!”</i>\n\n"
		+"Well, it seems she didn’t appreciate your proposition very much, not that you expected her to. You could just drop the subject and leave, or you could try and force yourself on her.");
		//[Force][Leave]
		menu();
		addButton(0, "Force", aikoFight).hint("You have needs! Force her.");
		addButton(14, "Leave", leave).hint("Don't force the subject. You screwed up, don't take it out on her.");
	}
}

private function aikoApologize1():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You put your hands up slowly, trying to look as non-threatning as possible. You’re just here to talk, you explain.\n\n"
	+"She keeps her arrow trained on you, but seems to soften just a little bit. Obviously, she’s a little taken aback. <i>“Talk? What could you possibly have to talk about with me?”</i> she says, frowning.\n\n"
	+"You tell her that you want to apologize for what you did. You’ve had a little time to reflect on it and you feel terrible about "+(flags[kFLAGS.AIKO_RAPE] <=0 ? "attacking her":"your brutal rape")+". There’s no way mere words could make up for your shameful actions, so you understand if she can’t forgive you; you just needed to tell her you’re sorry.\n\n"
	+"<i>“You’re damn right you’re sorry!”</i> she says indignantly, starting to lash out a little before reining herself in. She takes in a deep breath and lets it out slowly, relaxing her harsh stance just a bit and hesitantly lowering her bow.\n\n"
	+"<i>“But… If you really mean it…”</i> she says, thinking for a moment. <i>“And don’t think you’re getting off scott-free!”</i>she’s quick to add, scowling briefly before softening again.<i>“I’m still not very happy with you, but I’m willing to try a fresh start.”</i>");
	//[Sincere][Trick Her]
	menu();
	addButton(0, "Sincere", aikoApologySincere).hint("You truly are sorry for your actions.");
	addButton(1, "Trick Her", aikoApologyTrick).hint("Nope, just another trick to get close!").disableIf(player.cor <= 33,"<b>You are not corrupt enough for this deceit</b>");
}

private function aikoApologySincere():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You smile as she offers her hand, still visibly a little apprehensive, but willing to give you the benefit of the doubt. Grasping her hand firmly, you give it a light shake, and the two of you both relax.\n\n"
	+"<i>“I’m… I still need a little time, though,”</i> she says, putting her hands behind her back and fidgeting a little.\n\n"
	+"You tell her that’s fine; you can wait until she’s ready. Feeling as if your conscience grown a little lighter, you stroll off toward camp.");
	player.dynStats("cor", -5);
	flags[kFLAGS.AIKO_AFFECTION] = 50;
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==1) flags[kFLAGS.AIKO_CORRUPTION] -= 5;
	if (flags[kFLAGS.AIKO_CORRUPTION]<0) flags[kFLAGS.AIKO_CORRUPTION] = 0;
	doNext(camp.returnToCampUseOneHour);
}
	
private function aikoApologyTrick():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You smile as she offers her hand, still visibly a little apprehensive, but willing to give you the benefit of the doubt. Big mistake on her part. Your smile turns to an evil grin as you roughly grab her hand and yank her off balance, wrestling her to the ground.\n\n");
	player.dynStats("cor", 5);
	flags[kFLAGS.AIKO_AFFECTION] -= 8;
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==1) flags[kFLAGS.AIKO_CORRUPTION] += 10;
	if (player.str > 35) {
		outputText("She screams, struggling in vain against your superior physical strength as you beat her into submission, ripping her clothes off to claim your prize.\n\n"
		+"<i>“Y-you fucking "+player.mf("bastard","cunt")+"!”</i> she is in tears now, her face covered with dirt and scratches from the way you tumbled around with her. <i>“I knew I shouldn’t have trusted you!”</i>\n\n"
		+"You give her a swift smack across the face to let her know who’s boss. Despite her indignant glare, you have her pinned and overpowered—she’s not going anywhere. How will you rape her?");
		doNext(aikoRapeSex);
	} else {
		outputText("She yells out and plants a flaming slap on your face that sends you reeling, scrabbling to her feet quickly and putting some distance between herself and you.\n\n"
		+"<i>“You fucking psycho!”</i> she spits out, suppressing the urge to cry. <i>“First you say you want to apologize and then you try this? I’ve had it with your games!”</i>"
		+"Something seems to have snapped inside her... it looks like you’ve got a fight on your hands!");
		player.createOrFindStatusEffect(StatusEffects.DomFight);
		startCombat(new Aiko());
	}
}

private function aikoTalkE3():void {	
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var bowSkill:int = player.statusEffectv1(StatusEffects.Kelt);
	if (flags[kFLAGS.AIKO_AFFECTION]>=50) {
		outputText("You tell her you just want to talk today. "+(flags[kFLAGS.AIKO_HAS_FOUGHT]>0?"Aiko breathes a big sigh of relief and nods, smiling.":"")+"\n\n"
		+"<i>“Sure, I’d love to talk. I was starting to get a little lonely anyway,”</i> she says, taking a seat on the grass.\n\n"
		+"You tell her that you noticed she’s pretty handy with a bow" +(flags[kFLAGS.AIKO_HAS_FOUGHT]>0?", though you add that you already had some personal experience with her archery skills previously":"")+".\n\n"
		+"She blushes a little from the compliment and nods, rubbing the underside of her nose a bit and beaming.\n\n"
		+"<i>“Thanks. I learned from my mother… She was the village guardian before me.”</i>\n\n"
		+"You smile a bit and press her for more information, and she adds, <i>“Well... every kitsune village selects a guardian to protect the entrance from outsiders. It’s a great honor to be chosen for it… I wanted to do it ever since I was little.”</i>\n\n"
		+"You tell her that you have something in common with her, and go on to explain how you were chosen to become your village’s Champion, and what it means to you. Then you notice that she mentioned that “every” kitsune village chooses a guardian—does that mean there’s more than one?"
		+"<i>“Oh, yeah, sure. They’re all super top-secret though—even I don’t know where most of them are. We keep to ourselves mainly, though the village chiefs sometimes get together for really important stuff. I… actually I probably shouldn’t be talking about this with an outsider, " +(player.tail.type == Tail.FOX && player.tail.venom == 9 ? "even if "+ player.mf("he","she") +" is a nine-tails... ":"")+ " the Elders tend to get mad easily about this stuff, unfortunately.”</i>\n\n"
		+"You apologize for prying and ask if there’s anything she CAN talk about.\n\n"
		+"<i>“Sorry, I didn’t mean it like that, it’s just the village elders like their privacy… Ever since the demons appeared… Well, we were pretty isolated to begin with, but now with the demons, the elders are scared that contact with the outside world could bring corruption into our village. I don’t know if we have that much to worry about, honestly, but it HAS happened before...”</i>\n\n"
		+"You can tell she’s not very comfortable discussing it, and promptly decide to change the subject.\n\n");
		if (player.weaponRangePerk == "Bow") {
			outputText("You pull out your bow and ask if she’d be up for a little friendly competition, grinning widely. She seems pretty excited about it, and promptly goes to prepare the course.\n\n"
			+"Over the next hour, the two of you take turns shooting at the targets. ");
			if (bowSkill < 40) {
				outputText("Aiko utterly thrashes you with her superior skills, but she’s quite sweet about it, and you manage to pick up a few pointers from her.");
				player.addStatusValue(StatusEffects.Kelt,1,2);
			}
			else if (bowSkill < 90) {
				outputText("You give her a good run for her money, but Aiko still manages to come out on top in the end. She’s quite sweet about it though, and offers you a few pointers that might help you out.");
				player.addStatusValue(StatusEffects.Kelt,1,1);
			} else {
				outputText("Aiko is stiff competition, but she ends up being no match for your superior skills. You even graciously offer her a few pointers, and she seems grateful for the assistance.");
				flags[kFLAGS.AIKO_AFFECTION] += 5;
			}
		} else {
			outputText("The conversation drifts toward your various exploits elsewhere in Mareth, and the two of you chat it up for the better part of an hour before you tell Aiko that you should be heading back to camp. She bids you a fond farewell, and goes back to archery practice as you head out.");
		}
		outputText("\n\nUnfortunately you have to be heading back to camp now, so you bid her a fond farewell, and she goes back to her archery practice as you head out.");
	} else {
		outputText("You tell her you just want to talk, holding your hands up.\n\n"
		+(flags[kFLAGS.AIKO_APOLOGY_SINCERE] == 2 ? "She squints, keeping her bow trained on you the whole time, and says, <i>“Oh, yeah, I’ve heard THAT before.”</i>\n\n":"")
		+"You assure her that this time is different, keeping your hands held up defensively.\n\n"
		+"<i>“Why should I believe you? So far you’ve turned out to be nothing but an arrogant jackass who does whatever "+player.mf("he", "she")+" wants to whoever "+player.mf("he", "she")+" wants.”</i>\n\n"
		+(silly() ? "You gently hold a finger up and tell her she means “whomever”, not “whoever.” She gives you a “WTF” look and yells, <i>“Whatever!”</i>\n\n"+
		"No, whomev—oh, she was… okay then.\n\n"+
		"<i>“Shut up!”</i>\n\n"+
		"You swear to her that you’re not up to anything this time; you just want to talk.\n\n"+
		"<i>“Fine, but you stay over there. You better not try anything.”</i>\n\n":
		"<i>“Really, just talk? Give me one good reason why I should trust you.”</i>\n\n"+
		"You hold up your hands and remind her that she’s the one with her bow trained on you. "+
		"[if (player.weapon != WeaponLib.FISTS)Your weapon isn’t even in your hand, and she’d have already shot you by the time you could reach it.|You don’t even have a weapon.]"+
		"\n\nThis seems to relax her a bit, but she still keeps her bow aimed at your chest, her finger gently twitching as if waiting for you to make a move.\n\n"+
		"<i>“Fine, but you stay over there. You better not try anything.”</i>\n\n")
		+"You agree to her terms, keeping your distance from her. An awkward silence stretches on for some time before you finally decide to break the tension, mentioning Aiko’s skills with a bow.\n\n"
		+"<i>“My mother taught me,”</i>she says, nodding slightly. “She was the guardian before me. You better not think that trying to flatter me is going to make up for all you’ve done.”</i>\n\n"
		+"You assure her you meant nothing of the sort, and press her for more information about this “guardian” business.\n\n"
		+"<i>“Every kitsune village selects a guardian. It’s a great honor to be chosen to protect the entrance from outsiders who would seek to harm it.”</i> You infer from her tone that there is an unspoken <i>“like you”</i> to her sentence, but you don’t press the issue. No need to anger her further, especially if you’re getting nothing out of it.\n\n"
		+"You tell her that you’re not so different from her, in some respects, explaining how you were chosen to be your village’s champion and come through the portal.\n\n"
		+"<i>“Yeah, and I see what you’ve done with it. Some Champion.”</i>\n\n"
		+"Her words sting, but you have more questions, so you press on. She mentioned that “every” kitsune village chooses a guardian. You ask her if that means there’s more than one.\n\n"
		+"<i>“Of course, you didn’t think mine was the only one, did you? …Never mind. They’re hidden, and you won’t be getting their locations from me; I don’t even know where most of them are. "+((player.tail.type == Tail.FOX && player.tail.venom == 9) ?"you should be able to locate them if you want to, you are nine-tails and all.":"")+"”</i>\n\n"
		+"Nodding in understanding, you ask why they’re such a big secret.\n\n"
		+"<i>“We like our privacy, okay? And the elders think that if we have too much contact with the outside, we’ll become tainted by the demons’ corruption. I used to think they were just worry-warts, but they might have a point.”</i>\n\n"
		+"You get that her scathing remarks are probably aimed at you again; this conversation isn’t going as well as you had hoped. Then again, what could you expect, after how you’ve treated her? Looking for an escape, you tell Aiko that you have to be going back to camp now, but you enjoyed talking to her.\n\n"
		+"She doesn’t seem like she completely buys it, but she does take a breath and sigh, relaxing the string of her bow a little and nodding. <i>“Yeah, well… I suppose it wasn’t so bad talking to you, considering. But you’re still not off the hook, not by a long shot.”</i>\n\n"
		+"Without another word, you make your way back to camp.");
	}
	flags[kFLAGS.AIKO_AFFECTION] += 3;
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==1) flags[kFLAGS.AIKO_CORRUPTION] -= 5;
	if (flags[kFLAGS.AIKO_CORRUPTION]<0) flags[kFLAGS.AIKO_CORRUPTION] = 0;
	doNext(camp.returnToCampUseOneHour);
}

private function aikoApologize2():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("She’s right, you say, which seems to surprise her a bit. She has no reason to trust you, but you can see it in her eyes that she’s lonely, and you can help. You tell her if she’s willing to let bygones be bygones, you promise to give her the kind of companionship she’s yearning for right now.\n\n"
	+"She seems to wrestle with compromising her values for a moment before her expression softens at last, and she sighs. <i>“...fuck it. I know I’m gonna regret this, but... If you promise... Let’s just get this over with.”</i>")
	flags[kFLAGS.AIKO_AFFECTION] += 5;
	aikoConsSex();
}

private function aikoTalkAndSex():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell Aiko you came to talk, but you’d also be interested in sex later on. \n\n"
	+(flags[kFLAGS.AIKO_AFFECTION] >= 65? "She smiles cheerfully and approaches you, leaning in to give you a light peck on the cheek. <i>“Sounds like a plan to me,”</i> she says, grinning and backing up a bit. <i>“What did you want to talk about?”</i>":
		(flags[kFLAGS.AIKO_AFFECTION] >= 50 ? "She smiles cheerfully, nodding a little. <i>“Sure, we can talk. Play your cards right and I just might take you up on that second part,”</i> she says, but from her playful tone you can tell she’s just teasing. <i>“What did you have in mind?”</i>": 
			"<i>“Alright, we’ll talk. We’ll see if I feel like that second part after.”</i> she says, crossing her arms. <i>“Well, what did you want to talk about?”</i>")));
	talkAndSex = true;
	aikoTalk();
}

private function aikoTalk():void {
	if (!talkAndSex) {
		clearOutput();
		spriteSelect(SpriteDb.s_aiko);
		outputText("You tell Aiko that you just came to talk, nothing more."
		+(flags[kFLAGS.AIKO_AFFECTION] >= 65? "She smiles cheerfully and approaches you, leaning in to give you a light peck on the cheek. <i>“What did you want to talk about?”</i> she says, grinning and backing up a bit.":(flags[kFLAGS.AIKO_AFFECTION] >= 50 ? "She smiles cheerfully, nodding a little. <i>“Sure, we can talk. What did you have in mind?”</i>": "<i>“Alright, we’ll talk. Well, what did you want to talk about?”</i>")));
	}
	flags[kFLAGS.AIKO_AFFECTION] += 3;
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] == 1)
		flags[kFLAGS.AIKO_CORRUPTION] -= 5;
	if (flags[kFLAGS.AIKO_CORRUPTION]<0) flags[kFLAGS.AIKO_CORRUPTION] = 0;
	//[Giant Bees][Tentacle Beasts][Goblins][Akbal][Kitsune Culture][Aiko][Mansion Sisters][?Ayane?][Nine-Tails][Aiko's Family] [Archery]--[Leave]
	menu();
	addButton(0, "Giant Bees", talkBees).hint("Ask her about the Giant Bees in the forest");
	addButton(1, "Tentacle Beasts", talkTentacles).hint("Ask her about the Tentacle Beasts in the forest");
	addButton(2, "Goblins", talkGoblins).hint("Ask her about the Goblins");
	addButton(3, "Akbal", talkAkbal).hint("Ask her about the Demon Akbal you encountered near here");
	addButton(4, "Kitsune Culture", talkCulture).hint("Ask her about the Kitsune Culture");
	addButton(5, "Aiko", talkAiko).hint("Ask her about herself");
	addButton(6, "Mansion Sisters", talkMansionSisters).hint("Ask her about the Kitsune sisters in the Deep Woods Mansion");
	addButton(7, "Nine-Tails", talkNineTails).hint("Ask her about the Nine-Tails Kitsune");
	addButton(8, "Aiko's Family", talkFamily).hint("Ask her about her family");
	addButton(9, "Archery", talkArchery).hint("Ask her about her Archery skills");
	addButton(14, "Leave", leave).hint("Leave the clearing");
}

/////////////////////////////////////////////////////////////////////
////////////////////////TALK TOPICS//////////////////////////////////
private function  talkBees():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You decide to ask her about some of the local fauna. You ask if she’s had much experience dealing with the giant bee-women that you’ve seen in the forest sometimes.\n\n"
	+"<i>“The giant bees? They don’t usually come this deep into the woods, but I have run into them on occasion. They’re pretty friendly, I suppose, when they’re not trying to shove eggs into... places. At least they’re pretty cordial about it.”</i>\n\n"
	+"You chuckle, telling her that you’ve had your share of run-ins with them as well.\n\n"
	+"<i>“Some of the villagers occasionally do business with them though, in exchange for their honey. It makes a good sweetener for tea, and you can make some pretty tasty desserts and candy with it...”</i> She trails off, licking her lips, obviously having a good time imagining it.\n\n"
	+"<i>“Sorry, I don’t know much else about them.”</i>\n\n");
	if (talkAndSex) {
		outputText("You tell her that’s alright, and then let the conversation drift to other topics for a bit before you ask if she’s given much thought to your other proposition.");
		doNext(aikoSex);
	} else {
		outputText("You say that that’s alright, thanking her for her time, and tell her that you should be heading back to camp anyway.");
		doNext(camp.returnToCampUseOneHour);
	}
}
private function  talkTentacles():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You decide to ask her about some of the local fauna. You ask her what she knows about tentacle beasts.\n\n"
	+"<i>“They’re alright, I guess. I’ve never actually had one. Too much responsibility.”</i>\n\n"
	+"Wait, what? You ask her what she means by that.\n\n"
	+"<i>“Oh wait, did you mean the wild ones?”</i>\n\n"
	+"You tell her that yes, you did, and you weren’t aware that there was any other kind.\n\n"
	+"<i>“Oh! Well, yeah. Some kitsune like to keep them as pets. The wild ones are pretty dangerous, and I occasionally have to chase them off when they wander too close to our territory, but the tame ones are actually kind of cute. Like little... leafy... squids.”</i>\n\n"
	//+"(You tell her that now that she mentions it, you did see a kitsune with a tame tentacle monster once, but you didn’t know what to make of it. //(has seen consentacles) //Scene not in game currently
	+"You tell her you find that kind of hard to believe, but gesture for her to continue."//(has not seen consentacles)
	+"<i>“A lot of people assume just because they look like that that they’re nothing but wild beasts, but they’re actually pretty smart—just a little enslaved by their feeding habits. If you keep them well-fed though, they’re docile as kittens. Sometimes they can get a bit rambunctious, but you know how it is.”</i>\n\n"
	+"You tell her that no, you really don’t, but you’ll take her word for it.\n\n"
	+"<i>“It does get weird sometimes... I’ve seen girls that even make clothes for their tentacle beasts. It’s... actually a little disturbing.”</i>\n\n"
	+"You agree with her on that, and then the two of you discuss your various encounters with the creatures out in the wilds.");
	if (talkAndSex) {
		outputText("Finally, you bring up your previous proposal, asking if she’s still interested.");
		doNext(aikoSex);
	} else {
		outputText("Finally, you bid her farewell, telling her that you have to check in on your camp.");
		doNext(camp.returnToCampUseOneHour);
	}		
}
private function  talkGoblins():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You decide to ask Aiko about some of the local fauna. You ask whether she’s ever had any interactions with the ubiquitous goblin-folk that seem to be all over the place.\n\n"
	+"<i>“Goblins... boy, that’s a sad story. It’s a real shame what happened to them; they used to be so smart. Nowadays, as I’m sure you’ve noticed, they’re really only interested in one thing. There’s still a few who do the science thing, but even that is just geared toward making them better at screwing.”</i>\n\n"
	+"She shrugs, shaking her head sadly.\n\n"
	+"<i>“They don’t really bother us much, but there’s this one in particular that occasionally comes around to make vague passive-aggressive threats. She talks a big game, but I honestly doubt she’s interested in a fight. Anyway, I’d just try to steer clear of them. They’re really not that threatening, but they’re kind of territorial, [if (player.hasCock()) especially when “fresh meat” moves in, if you catch my meaning.|especially if a female encroaches on what they think of as “their turf”.]”\n\n"
	+"The two of you discuss some of your run-ins with goblin-folk back and forth for a while, and then you ");
	if (talkAndSex) {
		outputText("bring up your previous proposal, asking if she’s still interested.");
		doNext(aikoSex);
	} else {
		outputText("bid her farewell, telling her you should be checking in on your camp again soon.");
		doNext(camp.returnToCampUseOneHour);
	}		
}
private function  talkAkbal():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You decide to ask Aiko about some of the local fauna. You ask her what she knows about the demonic panther you’ve encountered occasionally near here.\n\n"
	+"<i>“Akbal,”</i> she says, practically spitting the name out. You can almost see the hairs on the back of her neck rising in response to the thought of him. <i>“Corrupted demon scum,”</i> she adds through clenched teeth, an uncharacteristic coldness in her voice. <i>“Believe it or not, he was once much, much worse. He was sealed into that form by a sorcerer, but unfortunately because of his power, the sealing was incomplete, and he took the monstrous form he has today. Powerful though he may be, he’s only a shadow of his former self, and the world is much better for it. I only wish I could finish the job the sorcerer started.”</i>\n\n"
	+"You note that she really seems to despise him, and ask her if there’s any particular reason for this.\n\n"
	+"<i>“He’s an enemy of the forest, plain and simple. We kitsune are spiritually tied to the land where we live—Akbal’s very presence in our forest is a blight. Thankfully, it doesn’t seem he can come too close to the village, due to the presence of this tree,”</i> she explains, pointing her thumb to the Ancient Tree behind her. <i>“The blessings of Marae are strong in this part of the forest, and our god, though weakened, still offers us some protection from the influence of corruption.”</i>\n\n"
	+"You nod, taking a moment to soak in what she said.");
	if (talkAndSex) {
		outputText("Thanking her for the information, you decide to change the subject, bringing up your previous proposition again.");
		doNext(aikoSex);
	} else {
		outputText("Thanking her for her time, you tell her that you have to go check back on your camp.");
		doNext(camp.returnToCampUseOneHour);
	}
}
private function talkCulture():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell her you’re interested in "
	+(player.kitsuneScore() >0 ?"expand your knowledge of the culture of your race":(flags[kFLAGS.AIKO_TALK_CULTURE] >0?"hearing what she has to say about kitsune culture":"learning more about kitsune culture"))+".\n\n"
	+(flags[kFLAGS.AIKO_TALK_CULTURE] ==0 ?"<i>“What, really?”</i>"+
	"You nod, saying that you’re just curious to learn more about [if (player.kistuneScore() > 0)your|her] race.\n\n<i>“":"<i>“Again? ")
	+"Well, let’s see, where to start... I haven’t seen much of the outside world, but I suppose we’re just like any ordinary village. People just, being people, you know? Day to day stuff, not all that interesting. We’ve got blacksmiths, bakers, carpenters, just like everybody else.”</i>\n\n"
	+"You nod, deciding that being more specific might be helpful. You ask if all kitsune are as fond of tricks as she is.\n\n"
	+"<i>“Heheh, yes. It’s a really satisfying experience for us, if you catch my drift.”</i>\n\n"
	+"With a slightly confused blink, you ask if she means what you think she does.\n\n"
	+"<i>“Sexually, yes. As a result, practical jokes and tricks are just so ingrained in who we are as a people. It’s even a part of our courtship rituals.”</i>\n\n"
	+(flags[kFLAGS.AIKO_AFFECTION]>=50?"You think about some of the times she’s tried to play jokes on you and coyly ask if that was her way of courting you."+
	(flags[kFLAGS.AIKO_AFFECTION]>=65?"She blushes a little and says, <i>“Well, that’s a strong possibility...”</i>":"She grins and replies back just as coyly, <i>“Could be... Maybe you’re just gullible.”</i>")+"\n\n":"")
	+"A thought suddenly comes to mind, and you realize that you’ve never encountered a male of her species. You ask whether all kitsune are female, or if you’ve just been unlucky.\n\n"
	+"<i>“Yes. No... um, both? I mean... Yes, most kitsune are... ‘female’ by birth, I suppose, but gender doesn’t really mean anything to us. The distinction between males and females is... a difficult concept for most kitsune to grasp. To us, it’s more like deciding what clothes to wear today. Just like how people can prefer certain styles of clothes, most kitsune prefer spending their time in one form or another. Vaginas are just all the rage right now.”</i>\n\n"
	+"You snort a bit, nodding, and tell her that you feel like you understand a bit more about her people now.\n\n");
	flags[kFLAGS.AIKO_TALK_CULTURE]++;
	if (talkAndSex) {
		outputText("The conversation gradually drifts toward other topics before you remind her of your other proposal again.");
		doNext(aikoSex);
	} else {
		outputText("While the experience has been educational, you should be heading back to check on your camp now.");
		doNext(camp.returnToCampUseOneHour);
	}		
}
private function  talkAiko():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell her that you had a few personal questions, if she doesn’t mind.\n\n"
	+"<i>“Go ahead. No guarantees that I’ll answer them all though,”</i> she replies, crossing her arms and grinning coyly.\n\n"
	+"You start by asking her about the strange ball that you found the first time you met her. It seemed pretty important to her; what exactly was so significant about it?\n\n"
	+(player.kitsuneScore() > 0? "<i>“My Ball? You are a kitsune yourself, shouldn't you know how our spirit vessel works?”</i> she says, widening her eyes. You tell her that you forgot how it works. She giggles a bit and then she playfully and lightly hits your forehead like she's knocking on a door. <i>“Forgetful, aren't we? hehehe. It's very important for us, let's see, where should I begin?\n\n":
	"<i>“Oh, my Ball... [if (flags[kFLAGS.AIKO_TALK_AIKO]>0)I thought I explained that already? ]"+
	"Every kitsune has one,”</i> she explains. <i>“It’s difficult to explain to a non-kitsune, but... Let me see if this works.\n\n")
	+"The Ball is like a... spirit vessel. If someone takes it from us, our link to it slowly fades away until...”</i> She shivers, pausing for a moment. <i>“Let me put it this way. The Ball contains a part of our soul... losing our link to it is... traumatic.”</i>\n\n"
	+"She doesn’t seem to be too keen on elaborating, but you grimace, imagining the implications. You decide to change the subject, bringing up her tails. She certainly has a lot of them; more than you’ve seen on the other kitsune you’ve encountered.\n\n"
	+"<i>“[if (flags[kFLAGS.AIKO_TALK_AIKO]>0)Yeah, did you forget? ]That’s because I’m [if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0)an eight|a seven]-tails.”</i> she explains, smiling as she runs a hand along the length of one of her tails. <i>“We’re born with just one, but it splits as we grow older and our magic and wisdom gets stronger. The number of tails we have is something of a status symbol. My [if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0)seventh|eighth] tail came in just a little while after the demons showed up[if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0), and my last one after we beat my sister as you well know].”</i>\n\n"
	+"You pause for a moment, wondering if your next question might be too insulting. Taking a deep breath, you resolve to take the risk, and you ask her if kitsune are some type of demon.\n\n"
	+"<i>“What? No!”</i> she blurts, then stops, composing herself. <i>“Sorry, sorry... [if (flags[kFLAGS.AIKO_TALK_AIKO]>0)I’ll explain it again. Try to keep up this time, okay?] No, we’re not. At least... we’re not like THEM,”</i> she says, wrapping her arms around herself reflexively, almost as a defensive gesture. <i>“Thinking about the similarities is uncomfortable to say the least, but it’s just our nature. We don’t mean any harm by it, I promise. We get a bad rap because our magic is sustained on life energy, and sometimes we get it from... well, sex. Alright, more than just sometimes, if I’m being honest. The demons though, they use their power to corrupt, they steal away people’s souls and do everything in their power to turn the whole world into their twisted playground.”</i>\n\n"
	+"You nod in understanding, [if (flags[kFLAGS.AIKO_AFFECTION]>=65)telling her that you know she’s more than just some succubus looking for a fix, and that you’re sorry if you offended her.|glad to know that she’s not just a succubus looking for a fix.] She seems to cheer up a bit, and says, <i>“Don’t worry... It’s something I’ve gotten used to. We had a bad reputation long before the demons arrived.”</i>\n\n"
	+"You decide to wrap the conversation up for now");
	flags[kFLAGS.AIKO_TALK_AIKO]++;
	if (talkAndSex) {
		outputText(" and ask if Aiko has put any thought into your other proposition.");
		doNext(aikoSex);
	} else {
		outputText("; you really should be heading back to check on your camp.");
		doNext(camp.returnToCampUseOneHour);
	}
}
private function  talkMansionSisters():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You decide to ask her about some of the other kitsune you’ve met along your adventures. You tell her all about the three kitsune sisters that you’ve seen in the forest, and ask if they’re from Aiko’s village as well.\n\n"
	+"<i>“Oh, those three. Yeah, they’re originally from our village, but they don’t live there anymore. They repeatedly ignored the elders’ pleas to stop interacting so much with outsiders, and finally got fed up with it and decided to move out on their own. I’d stay away from them if I were you. They may seem nice, but they’re serious troublemakers.”</i>\n\n"
	+"You can’t help but point out that what she’s doing right now is, in fact, interacting with an outsider, and won’t she get in trouble for the very same thing?\n\n"
	+"<i>“Th-that’s different! I’m the guardian, I HAVE to be out here to protect the village! I... It’s my responsibility to act as a liaison!”</i> she says, blushing terribly.\n\n"
	+"<i>“A-anyway, at least I don’t go overboard like they do.”</i>\n\n"
	+"You ask what she means by “overboard.”\n\n"
	+"<i>“Those three just don’t know when enough is enough. They lure travelers to that mansion of theirs, and... well once you’re past the threshold, you’re already a part of the illusion. If they wanted to keep you there, there’s nothing you can do about it. You wouldn’t be the first hapless traveler to get spirited away by amorous kitsune, you know. We’re not all as nice as I am.”</i>\n\n"
	+"You chuckle a bit, thanking Aiko for the warning. It seems you still have a lot to learn when it comes to kitsune.");
	if (talkAndSex) {
		outputText("You tell her that you might be in the mood for some mischief yourself and remind her of your other proposition.");
		doNext(aikoSex);
	} else {
		outputText("Unfortunately, you’ve been away from camp for too long, and you should probably return to check up on it.");
		doNext(camp.returnToCampUseOneHour);
	}
}
private function  talkNineTails():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("<i>“Oh, you want to know about our nobility, hey?”</i> She folds her arms under her large, tightly bound breasts. You can see she's aiming to become one herself, already having [if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0)eight|seven] tails. [If (player.kitsuneScore() > 0)<i>“You should know stuff like this by now, if you want to be a full fledged kitsune, you need to know who your elders are, heheh”</i> She laughs with her tongue out of her mouth, pulling a mischievous grin.]\n\n"
	+"<i>“Nine-tails are the oldest and wisest kitsune, they are generally very rare and revered, in our clan we have only six Nine-tails, my mother being one of them.”</i> You listen carefully as you find this topic very interesting"
	+((player.tail.type == Tail.FOX && player.tail.venom == 9)?" especially since it is so applicable to you.\n\n":".\n\n")
	+"<i>“When a kitsune gets their last tail, a ceremony is induced and all of the village celebrates at their newly acquired leader. During said ceremony, the new nine tails can select one or more retainers who will act as their servants and lieutenants, these retainers need to have five or more tails and may even be from other clans. It is a very high honor to be selected.”</i>\n\n"
	+"You nod as you see her lips stop moving. You ask if she has ever became a retainer, noting that she has [if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0)eight|seven] tails. You see her with an irritated grin immediately after you finished talking, it's clear something is up.\n\n"
	+"<i>“Well... yes. I was a retainer, to the last nine tails ever created in my village. Her name is “Ginko” ... let's just say she loved nagging us and had... somewhat of a passion for sexually dominating us. That is until I became the guardian of my village.”</i>\n\n"
	+"With a grin, you giggle at her obvious distaste for her time as a servant, earning a raspberry from her irritated form before sharing a laugh.\n\n");
	if (talkAndSex) {
		outputText("Thanking her for the information, you decide to change the subject, bringing up your previous proposition again.");
		doNext(aikoSex);
	} else {
		outputText("Thanking her for her time, you tell her that you have to go check back on your camp. <i>“Sayonara, [name].”</i>");
		doNext(camp.returnToCampUseOneHour);
	}
}
private function  talkFamily():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell her that you had a few personal questions, if she doesn’t mind.\n\n"
	+"<i>“Go ahead. No guarantees that I’ll answer them all though,”</i> she replies, crossing her arms and grinning coyly.\n\n"
	+"You start by asking her if she has any family in this village she’s always talking about.\n\n"
	+"<i>“Family? Y...yeah, I do. My mother is one of the elders, and the previous guardian. She taught me everything I know. Her mate is a kitsune from another hidden village; she met him way back when she was just a three-tails. I don’t know whether he’s my father though.”</i>\n\n"
	+"Seeing your puzzled look, she adds, <i>“Oh, it’s not that uncommon in kitsune villages. Most kitsune don’t know for sure who their fathers are. When I was younger, I just figured it was that way everywhere.”</i>\n\n"
	+"You nod, and then ask if she has any siblings, figuring that if kitsune society is so supportive of free love that large families must be commonplace.\n\n"
	+"<i>“I... well, yes... [if (flags[kFLAGS.AIKO_BOSS_INTRO]>0)Well obviously you dumbass, remember Yamata? My half-sister?”</i>|”</i> Aiko’s demeanor suddenly becomes melancholy, and you ask her if it was something you said.\n\n“No, I just... I did have a half-sister, but I haven’t seen or spoken to her in years. I’m not sure where she is, or if she’s even still alive—she disappeared a short while after the demons appeared. Though... we didn’t really get along very well in the time leading up to that.”</i>]\n\n"
	+"You nod a bit, gently rubbing your chin. You tell Aiko that she doesn’t need to divulge anything too personal if it’s making her uncomfortable, ");
	if (talkAndSex) {
		outputText("saying that you can drop the conversation here if she wants.\n\n"
		+"<i>“Yeah, I'd prefer it that way, thanks.”</i>\n\n"
		+"You mention your previous suggestion in the hopes of cheering her up again.");
		doNext(aikoSex);
	} else {
		outputText("saying that you should be heading back to camp anyway.\n\n"
		+"<i>“Yeah, I'd prefer it that way, thanks.”</i>");
		doNext(camp.returnToCampUseOneHour);
	}
}
private function  talkArchery():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You bring up Aiko’s archery skills, and she proudly smiles at the compliment, though you can see a slightly embarrassed blush on her cheeks.\n\n");
	if (player.weaponRangePerk == "Bow") {
		flags[kFLAGS.AIKO_TALK_ARCHERY]++;
		if (player.statusEffectv1(StatusEffects.Kelt) > 90) {
			if (flags[kFLAGS.AIKO_TALK_ARCHERY] == 1) {
				outputText("You tell her you’ve been trying to learn as well, pulling out your own bow to show her. She examines it for a bit, smiling as she runs her hand down the side.\n\n"
				+"<i>“Wow, this is quality work! Centaur make, if I’m not mistaken... Where did you get it?”</i>\n\n"
				+"You explain to her your dealings with Kelt, "
				+(player.statusEffectv2(StatusEffects.Kelt)<75?"remarking on the arrogant centaur’s brash attitude and how awful it is putting up with him.":"sighing almost dreamily as you describe his rugged good looks and no-nonsense teaching methods.")
				+"\n\n<i>““If you want, you can use my target range, but I don’t know how much I could help. It sounds like you’ve already got some skills.”</i>\n\n");
			} else {
				outputText("You tell her you were wondering if she’d be willing to give you another lesson.\n\n"
				+"<i>“I don’t really know if I’ve got anything left to teach,”</i> she says, shrugging a bit. <i>“I hate to admit it but you’re already better than I am.”</i>\n\n");
			}
		}
		else {
			if (flags[kFLAGS.AIKO_TALK_ARCHERY] == 1) {
				outputText("You tell her you’ve been trying to learn as well, pulling out your own bow to show her. She examines it for a bit, smiling as she runs her hand down the side.\n\n"
				+"<i>“Wow, this is quality work! Centaur make, if I’m not mistaken... Where did you get it?”</i>\n\n"
				+"You explain to her your dealings with Kelt, "
				+(player.statusEffectv2(StatusEffects.Kelt)<75?"remarking on the arrogant centaur’s brash attitude and how awful it is putting up with him.":"sighing almost dreamily as you describe his rugged good looks and no-nonsense teaching methods.")
				+" Afterward, you ask if she would be willing to give you a lesson or two.\n\n"
				+(flags[kFLAGS.AIKO_AFFECTION] >= 50 ?"<i>“I’d be happy to give you some pointers, [name].”</i>":(flags[kFLAGS.AIKO_AFFECTION] >= 35 ?"<i>“Okay, I’ll teach you... Just don’t make me regret this.”</i>\n\n":"<i>“No way am I teaching you anything now, maybe you should try being nicer.”</i>]\n\n")));
			}
			else {
				outputText("You tell her you were wondering if she’d be willing to give you another lesson.\n\n"
				+(flags[kFLAGS.AIKO_AFFECTION] >= 50 ?"She nods happily and gives you a cheerful nod, saying, <i>“Of course, I’ll go set up the targets!”</i>\n\n":"She thinks about it for a second and then finally says "+(flags[kFLAGS.AIKO_AFFECTION] >= 35 ?"<i>“Okay, I’ll teach you some more.”</i>\n\n":"<i>“No, not today. You want free archery lessons, maybe you should try being nicer.”</i>\n\n")));
			}
		}
		if (flags[kFLAGS.AIKO_AFFECTION] >= 35) {
			outputText("The two of you take turns shooting at the targets, swapping stories back and forth in between shots. Even if Kelt is a little more skilled, Aiko’s cheery disposition more than makes up for it, and you find yourself grateful to have found an archery partner that isn’t as arrogant, crude, and snide as he. ");
			if (player.statusEffectv1(StatusEffects.Kelt) < 40) {
				outputText("In the end, she still proves more than a match for you, but thankfully she doesn’t rub it in your face. You come away feeling like you’ve learned a lot in your short time with her.\n\n");
				player.addStatusValue(StatusEffects.Kelt,1,3);
			}
			else if (player.statusEffectv1(StatusEffects.Kelt) < 90) {
				outputText("In the end you give her a decent run for her money, but ultimately it is apparent you still have much to learn from her. You feel like you’ve picked up a few good tips and tricks from her.\n\n");
				player.addStatusValue(StatusEffects.Kelt,1,1);	
			} else {
				outputText("In the end, she was right; you beat her fair and square, and you can’t say you learned anything new, but it was fun. And you feel a bit closer to her for the experience");
			}
		}
	} else {
		outputText("You tell her you would be interested in learning to use a bow as well, if she felt like teaching you. She grins sheepishly, taking out her longbow and holding it close, gently running her hand along it.\n\n"
		+(flags[kFLAGS.AIKO_AFFECTION] >= 50 ?"<i>“I would love to, believe me, but... I don’t really have one for you to use, and this one is sort of really important to me. It’s not that I don’t trust you with it, but... I’d be devastated if anything happened to it. Sorry... If you can find one somewhere though, I’d be happy to help you learn to use it!”</i>":"<i>“Sorry, no can do. I don’t have a spare, and I’m not going to let just anyone touch mine... It’s really important to me, and I’d be devastated if anything happened to it. If you get your own, maybe I’d be willing to give you a few pointers.”</i>")
		+"You nod and apologize for wasting her time")
	}
	if (talkAndSex) {
		outputText(".\n\nYour previous offer still stands though...");
		doNext(aikoSex);
	} else {
		outputText(", but unfortunately, you should be getting back to camp now.");
		doNext(camp.returnToCampUseOneHour);
	}
}	

/////////////////////////////////////////////////////////////////////
/////////////////////SEX AND FIGHT OPTIONS///////////////////////////
private function aikoSex():void {	//same for e3 onward
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell her that you’d like to have sex with her"+(flags[kFLAGS.AIKO_HAS_FOUGHT] > 0?", but you’re not out to force her this time":"")+".\n\n");
	if(flags[kFLAGS.AIKO_AFFECTION]>=50) {
		outputText("She seems pretty happy to hear you say that, and eagerly begins to strip down.\n\n"
		+"<i>“You have no idea how glad I am to hear that,”</i> she says, dropping her clothes to the side. <i>“I’ve been going mad with loneliness out here with nobody to talk to and I could use a little companionship and... oh, now I’m ranting...”</i>\n\n"
		+"You chuckle a little at how eager she is to get things started, but you can’t complain about her enthusiasm.");
		aikoConsSex();
	}
	else {
		outputText("<i>“You just can’t get it through your thick skull, can you?”</i> she says, shaking her head. <i>“You know, I just might have let you, if I felt like I could trust you.”</i>\n\n"
		+"You can see in her eyes that she’s practically starved for some companionship, but her needs are having a hard time fighting against her pride and obvious dislike for you.\n\n"
		+"You’ve got needs too though… What are you going to do about them?");
		//[Apologize][Force][Leave]
		menu();
		addButton(0, "Apologize", aikoApologize2).hint("Apologize for being a mean-ass fucker.");
		addButton(1, "Force", aikoFight).hint("You have needs! Force her.");
		addButton(14, "Leave", leave).hint("Don't force the subject. You screwed up, don't take it out on her.");
	}
}

private var playerchoice:Boolean = true;
public function aikoConsSex():void {		
	//[Missionary] [DoggyStyle] [BJ] [GetLicked] [Tailjob]--[Leave]
	menu();
	if (player.hasCock()) {		
		addButton(0, "Missionary", aikoSexMissionary).hint("");
		addButton(1, "DoggyStyle", aikoSexDoggy).hint("");
		addButton(2, "BJ", aikoSexBJ).hint("Have her pleasure your dick with her mouth.");
	}
	if (player.hasVagina())
		addButton(3, "Get Licked", aikoSexCunni).hint("Let her explore the soft folds of your pussy with her tongue.");
	if (flags[kFLAGS.AIKO_AFFECTION]>= 75 && player.hasCock())
		addButton(4, "Tailjob", aikoSexTailjob).hint("");
	if (flags[kFLAGS.AIKO_CORRUPTION] > 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0) {
		addButton(5, "Submit", submitToAiko).hint("Submit to Aiko and see what she does with you");
	}
	addButton(14, "Leave", leave).hint("Leave the clearing without touching her.");
}

private function aikoSpar():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You smile and suggest maybe you could have a friendly competition, if she was interested.\n\n"
	+"<i>“Competition eh? I’m not a pushover, you know,”</i> she says, taking a couple of mock boxing swings at the air. <i>“Okay, I’m game. What are the stakes?”</i>\n\n"
	+"You contemplate for a bit, and then suggest that the loser would have to pleasure the winner. She laughs a little, and then nods.\n\n"
	+"<i>“Sounds fair to me. Alright, whenever you’re ready!”</i>");
	flags[kFLAGS.AIKO_AFFECTION] += 2;
	player.createOrFindStatusEffect(StatusEffects.Spar);
	startCombat(new Aiko());
}

public function sparWithAikoWin():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("Aiko drops to one knee, panting heavily and supporting herself with her bow. In spite of her obvious battle exhaustion, she is grinning from ear to ear.\n\n"
	+"<i>“Okay, I admit it, you’re good,”</i> she says, sitting back to catch her breath. <i>“Well, to the victor go the spoils... What’s on your mind?”</i>");
	playerchoice = true;
	if (player.hasStatusEffect(StatusEffects.Spar)) {
		flags[kFLAGS.AIKO_SPAR_VICTORIES]++;
	}
	aikoConsSex();
}

public function sparWithAikoLose(aikoLust:int):void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You fall to the ground in a heap, overcome by [if (player.lust >= player.maxLust())lust|exhaustion]. Aiko stands over you for a moment, hands on her hips as she smirks victoriously.\n\n"
	+"<i>“Well, to the victor go the spoils...”</i> she says, giggling as she advances on you.");
	playerchoice = false;
	//[Consensual] - Aiko’s choice - Based on Aiko’s current Lust score and/or Affection for the PC
	var options:Array = [];
	if (flags[kFLAGS.AIKO_AFFECTION] >= 60 && aikoLust >= 60) {			
		if (player.hasCock()) {		
			options.push(aikoSexMissionary);
			options.push(aikoSexDoggy);
			options.push(aikoSexBJ);
		}
		if (player.hasVagina())
			options.push(aikoSexCunni);
		if (flags[kFLAGS.AIKO_AFFECTION]>= 75 && player.hasCock())
			options.push(aikoSexTailjob);
	}
	if (options.length > 0) {
		doNext(options[rand(options.length)]);
	} else {
		outputText("\n\n<i>“Come to think of it, I'm not really in the mood to do that now. Bye”</i> she says, waving a hand before disappearing behind the great tree.");
		if (player.hasStatusEffect(StatusEffects.Spar)) {
			player.removeStatusEffect(StatusEffects.Spar);
		}
		cleanupAfterCombat();
	}
}

private function aikoFight():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	if (flags[kFLAGS.AIKO_CORRUPTION] > 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0) {
		outputText("You tell her that you’re going to fuck her whether she likes it or not, readying your [weapon]. She grins a wicked grin, seeming to be quite pleased with your enthusiasm, and shouts, <i>“That’s what we like to hear! Come and fuckin’ get it, bitch!”</i>")
	} else {
		outputText("Making up your mind, you lunge at her without warning, your [weapon] raised and ready to fight. She jumps back out of the way, narrowly dodging your sudden attack, and raises her bow to defend herself.");
		if (flags[kFLAGS.AIKO_AFFECTION] >= 50)
			outputText("<i>“H-hey! What the hell?! What are you doing?”</i> she yells in surprise, but your only reply is to take a ready stance, preparing to fight her.");
		else outputText("<i>“Alright, we’ll do it your way again!”</i> she barks, prepared to fight.");
		flags[kFLAGS.AIKO_AFFECTION] -= 2;
	}
	player.createOrFindStatusEffect(StatusEffects.DomFight);
	startCombat(new Aiko());
}
	
public function pcWinsDomFight():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	if (player.hasStatusEffect(StatusEffects.DomFight))
		player.removeStatusEffect(StatusEffects.DomFight);
	if (flags[kFLAGS.AIKO_CORRUPTION] < 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0) {
		outputText("Aiko stumbles and falls to the ground, panting hard. Though she puts up a good fight, in the end it seems her muscles are too weak to carry on, and she just stays slumped on the ground, looking up at you with a crazed fire in her eyes.\n\n"
		+"<i>“Eh...heh...haha... So you DO know how to show a girl a good time. Maybe you’re not such a "+ player.mf("limp-dicked choir boy","washed-up whore")+" after all.”</i> she says, grinning sarcastically. <i>“Well come on, or are you too much of a wuss to go through with it now that I’m on the ground?”</i>\n\n"
		+"Even though you know she’s just doing it to piss you off, her words have the desired effect, and you are suddenly struck with the urge to teach this passive-aggressive bitch a lesson. What will you do to her?");
	} else {
		outputText("Aiko drops to one knee, panting heavily and supporting herself with her bow. Mustering up the last reserves of her willpower, she lines up one last arrow and releases it, but her strength is clearly spent—the arrow lobs through the air with all the grace of a drunken bumblebee, flying wide and clattering against the trunk of a tree.\n\n"
		+"<i>“Wha… what are you going to do?”</i> she says between breaths, collapsing as her longbow disappears out from under her.\n\n"
		+"That’s a good question. She’s at your mercy now, so you could do just about whatever you want to her. "+ (player.cor >= 40 ? "An evil smirk crosses your face as you think about teaching this little bitch a lesson for crossing you. ":"") +"Will you rape her, and if so what will you do?");
	}
	aikoRapeSex();
}

public function pcLosesDomFight():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	if (player.hasStatusEffect(StatusEffects.DomFight))
		player.removeStatusEffect(StatusEffects.DomFight);
	if (flags[kFLAGS.AIKO_CORRUPTION] < 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0) {
		var x:int = rand(player.cocks.length);
		outputText("You fall to the ground, giving in to the crazed vixen’s power. Aiko approaches with a toothy grin and a glimmer of insanity in her eyes as she begins to disrobe, letting her clothes lay haphazardly where they drop. She plants a foot on your chest and pushes you back, giving you a smug little smirk as you collapse backward onto the ground.\n\n"
		+"With a crack of her knuckles she begins to methodically tear your [armor] away from your form, leaving you nude and fully exposed to her wrath. Too weakened to resist her advances, you are forced to watch as she lowers herself down to straddle you, clawing her fingernails down your [chest]. The sensation is both painful and arousing, eliciting a small groan from your throat as her nails leave behind a series of deep, quickly-reddening scratches.\n\n"
		+"<i>“It’s not as fun when you’re the bitch, is it?”</i> she says with a level of calmness that is more disconcerting than if she had screamed it.\n\n"
		+"She continues to have her way with your body, her nails gently carving their way across your exposed flesh. Leaning forward, she takes a firm, painful grip on your earType ear, and whispers, <i>“I’m going to enjoy this.”</i>\n\n"
		+"You wince in pain as she pulls hard on your ear for a moment, and then begin to gasp for breath as you feel her thin but surprisingly strong fingers slowly wrap around your windpipe. She leans forward, pursing her lips, and forces a deep, utterly wrong kiss onto your mouth, violating your mouth with her tongue as she slowly exhales. The bittersweet poison of licorice fills your throat, and you can slowly feel yourself succumbing to the pleasures of her torture, your wounds tingling as her corrupted flames spread through your body.\n\n"
		+"Suddenly, you are putty in her hands. You know you would do anything just to feel the sweet release brought on by Aiko’s wonderful cruelty… for just one more moment of sweet torment.\n\n"
		+"To your "+(player.findPerk(PerkLib.Masochist) >= 0?"delight":"horror")+", your foxy dominatrix's hands both clasp firmly around your neck, bearing down on you. You choke and thrash weakly, staring up at her vindictive grin as darkness begins to enclose on your vision. At the edges of your consciousness, you can feel Aiko’s tails slowly sliding down toward your groin, "+(player.hasCock()?"wrapping around your [cocks]":"")+(player.hasVagina() && player.hasCock() ?" and ":"")+(player.hasVagina()?"beginning to tease your [clit] with their furry bottle-brush tips":"")+".\n\n"
		+"You gasp violently as her hands let up just enough to pull you back from the brink, filling your lungs with sweet fresh air at the exact moment that she begins to pump her tails "+(player.hasCock()?"up and down your [cocks]":"")+(player.hasVagina() && player.hasCock() ?" and ":"")+(player.hasVagina()?"into your [vagina]. The worst part is that it feels so GOOD":"") +", the combination of the sensations pulling you toward your climax by leaps and bounds while Aiko laughs derisively at your pathetic struggles underneath her.\n\n"
		+"<i>“Oh, silly [name]... Did you think I was going to strangle you?”</i> she says, bearing down on your windpipe again and licking her lips. <i>“I’m not gonna kill you, sweet thing... but surely you don't think I’m going to let you get off that easy? That’s no fun at all.”</i>\n\n"
		+"Your mind screams in protest, your hips weakly wiggling underneath her, willing yourself toward an orgasm that simply won’t arrive. Each time she pulls you to the brink, she backs off, forcing you to endure the blissful agony of being on the edge of consciousness and climax all at once.\n\n"
		+(player.hasCock()?"As your vision darkens once more, you can feel the heat of Aiko’s sopping cunt against the tip of your [cock "+(x+1)+"], teasing you with their slick depths. The soft, warm lips dilate tantalizingly around your head, and with an abrupt drop, she mounts your member,[if (player.hasKnot("+x+")) careful not to let your knot slip in and] squeezing down tightly!\n\n":"")
		+(player.hasVagina() ? "The tails in your [vagina] double their effort, pounding you mercilessly as Aiko’s pleasure begins to boil over.\n\n":"")
		+"Her hands suddenly release their grip on your throat entirely, and as you hoarsely fill your lungs with sweet, wonderful fresh air, your body is wracked with a tremendous orgasm, sending you into a frenzy from head to toe. Aiko’s tails frizz up with pleasure as she seems to synchronize with you, clawing at her own body with both hands as she rides the wave of her own climax. "+(player.cumQ() > 350 && player.hasCock() ?"Her abdomen swells with seed as your orgasm goes on for even longer than usual, a side effect of the strange asphyxiation-play that she put you through.":"")+"\n\n"
		+"Released from your pleasurable torment and finally able to climax, you lay panting on the ground, gasping for breath as Aiko slowly dismounts you"+(player.cumQ() > 350 && player.hasCock() ?", allowing the pent-up seed to gush out over your lower body":"")+". Your last sight is that of her retrieving her robes just before you pass out from exhaustion.");
		if (player.hasCock())
			player.orgasm('Dick');
		if (player.hasVagina())
			player.orgasm('vagina');
	} else {
		outputText("You fall to the ground in a heap, overcome by your [if (player.lust >= player.maxLust())lust|wounds]. Aiko stands over you for a moment, murmuring an incantation under her breath, and you watch her point her first two fingers at your forehead just before the world goes dark.\n\n");
	}
	cleanupAfterCombat();
}

public function aikoRapeSex():void {
	//[Fuck Vagina][Fuck Ass][Humiliate][Leave]
	menu();
	addButton(0, "Fuck Vag", aikoRapeFuckVag).hint("Pound ze foxy pussy!").disableIf(!player.hasCock(),"Requires a dick you moron!");
	addButton(1, "Fuck Ass", aikoRapeFuckAss).hint("Get some of that tight, juicy ass!").disableIf(!player.hasCock(),"Requires a dick you moron!").disableIf(player.cockThatFits(50) < 0,"You dick too huge man, She be delicate in the heinie");
	addButton(2, "Humiliate", aikoRapeHumiliate).hint("Make her your pet bitch!");
	if (flags[kFLAGS.AIKO_BALL_RETURNED] == 1) {
		addButton(3, "Fist Her", aikoFistHer).hint("Have a feel inside her pussy.");		
		addButton(4, "Get Licked", aikoRapeGetLicked).hint("This time you want Aiko to eat you out!").disableIf(!player.hasVagina(), "This scene kind of needs some lady parts, you know...");			
	}
	if (flags[kFLAGS.AIKO_BALL_RETURNED] != 1)
		addButton(14, "Leave", aikoRequestsBallAfterLose).hint("Leave the clearing without touching her.");
	else 
		addButton(14, "Leave", leave).hint("Leave the clearing without touching her.");
}

/**
 * Update Aiko's flags and the players corruption after rape.
 */
private function postRapeUpdate(): void {
	if (flags[kFLAGS.AIKO_CORRUPTION] >= 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]>0) {
		flags[kFLAGS.AIKO_AFFECTION] += 5;
	} else {
		flags[kFLAGS.AIKO_AFFECTION] -= 5;
	}
	flags[kFLAGS.AIKO_RAPE]++;
	if (player.cor <= 50) {
		player.dynStats("cor", 5);
		if (player.cor > 50) {
			player.cor = 50;
		}
	}
	if ((player.cor > flags[kFLAGS.AIKO_CORRUPTION] || player.hasPerk(PerkLib.Sadist)) && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==1) {
		flags[kFLAGS.AIKO_CORRUPTION] += 12;
	} else if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] == 1) {
		flags[kFLAGS.AIKO_CORRUPTION] += 8;
	}
	if (flags[kFLAGS.AIKO_CORRUPTION] > 100) {
		flags[kFLAGS.AIKO_CORRUPTION] = 100;
	}
}

/**
 * Update Aiko's flags and the players corruption after consensual sex.
 */
private function postSexUpdate(): void {
	flags[kFLAGS.AIKO_AFFECTION] += 4;
	if (player.cor >= 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0) {
		flags[kFLAGS.AIKO_CORRUPTION] += 4;
	}
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0 && flags[kFLAGS.AIKO_CORRUPTION] >= 50 && player.cor <= flags[kFLAGS.AIKO_CORRUPTION]) {
		player.cor += 2;
		flags[kFLAGS.AIKO_CORRUPTION] -= 2;
	}
}

private function aikoRapeFuckVag():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var x:int = rand(player.cocks.length);
	outputText("The temptation to take advantage of the defeated priestess is just too much to pass up. You roughly grab the sash that holds together the lower half of her robes, tugging it until it comes undone, and use it to tie Aiko’s arms behind her back. She doesn’t put up much of a fight, though the worried look on her face tells you she has an inkling what you have in mind.\n\n");
	if (flags[kFLAGS.AIKO_TIMES_MET]==1)
		outputText("<i>“I… please, I just wanted my Ball,”</i> she pleads, looking up at you as you turn her onto her back. "+(player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ?"You give the impertinent girl a hearty slap across the cheek, telling her to quit blubbering and shut her whore mouth. This is her punishment for trying to trick you, and if you’re feeling generous later, maybe you’ll deign to give it back to her.":"")+" Eagerly tossing her robes aside, you spread her legs to reveal a moist little slit bearing a cute little lotus tattoo just above her pubic mound. With a lascivious grin, you remove your [armor], revealing your [cocks], and begin to rub against her pervertedly.\n\n"
		+"<i>“P-please! Do whatever you want, but… but promise!”</i> she says, small tears welling ");
	else
		outputText("<i>“I… please, I didn't want to fight you!”</i> she pleads, looking up at you as you turn her onto her back. "+(player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ?"You give the impertinent girl a hearty slap across the cheek, telling her to quit blubbering and shut her whore mouth.":"")+" Eagerly tossing her robes aside, you spread her legs to reveal a moist little slit bearing a cute little lotus tattoo just above her pubic mound. With a lascivious grin, you remove your [armor], revealing your [cocks], and begin to rub against her pervertedly.\n\n"
		+"<i>“P-please! Why are you doing this?!”</i> she says, small tears welling ");
	outputText("up at the corners of her eyes as your hands tug at her chest wrap, letting her perky D-cups bounce free. "+(player.cor >= 50 || player.hasPerk(PerkLib.Sadist)? "You smack her around a bit more, telling her to shut up"+ (flags[kFLAGS.AIKO_TIMES_MET] ==1 ?" about her stupid ball":"") +". You could have sworn you told this bitch to keep her damn trap shut! ":"You do your best to shrug off the pangs of guilt, knowing that you’re in it too deep to turn back now.")+" She sniffles a little, biting her lip. It seems she’s prepared to suffer through whatever you plan to do to her, not that she had much choice in the matter."+(player.cor >= 50 ||player.hasPerk(PerkLib.Sadist)?" At least now, perhaps she’ll stop whining long enough for you to get off!":"")+"\n\n"
	+"You place the tip of your [cock "+(x+1)+"] against her quivering snatch, bearing down on her just a bit. Her moist love-hole is tight, but yields to you with relative ease. You let out a moan as you sink into her little by little, her soft, muscular walls wrapping around you and enveloping you with an almost ethereal warmth. [if (player.cocks["+(x+1)+"].length >= 40) Just when you are certain that she should be unable to take any more of your enormous manhood, a slurping contraction draws you even deeper.] "
	+(player.hasKnot(x)?"When you feel your knot pushing against her lips, you shift your weight to lean over her and begin to pound her pussy with your [cock "+(x+1)+"].":"When you feel your hips rocking against hers, you shift your weight to lean over her and begin to pound her pussy with your [cock "+(x+1)+"].")
	+" You shift focus to toying with her breasts, [if (player.hasPerk(PerkLib.Sadist)) biting her nipples painfully| pinching her nipples] while your hips roughly slam against her. As you begin to ramp up your furious thrusting, Aiko bites her lip and looks off to the side, her cheeks a glowering red. You can tell by the way her throat muscles tense up that she is doing her best to suppress her moans.\n\n"
	+""+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "Roughly, you grasp her by the hair and yank her back to facing you, barking at her that you like to look your sluts in the eyes when you fuck them. She meekly complies, blinking away tears in her eyes. Yes, that’s a good slut…":"") +"\n\n]"
	+"If one thing can be said in her favor, it’s that she knows how to please a cock—her pussy ripples around you with an incredible degree of control, squeezing, pulling and kneading your shaft with what can only be a practiced skill. You can only assume that she is trying to get you to cum quickly so she can get this over with, and she may just get her way if this keeps up.\n\n"
	+(player.hasKnot(x)?"You feel yourself nearing your end and slam your knot home, Aiko's tight pussy having barely enough give for you to squeeze it in, but it lodges in place and grows to the max, locking you together.\n\n":"")
	+((player.cumQ() <= 150))? "You let out a loud moan as your climax finally boils forth, shooting "+ (player.hasKnot(x)? "streams of cum into Aiko’s abused pussy before forcefully yanking out your knot, much to Aiko's displeasure and she screams from the pain of the forceful extraction.":"a few streams of cum into Aiko’s abused pussy, pulling out and letting the last few ropes spray across her stomach.")+"\n\n":
	((player.cumQ() <= 350)? "You let out a loud moan, feeling your [cock] distend noticeably as a veritable river of semen spills into Aiko’s abused pussy. "+(player.hasKnot(x)?"Your knot prevents any of your cum from leaking out and her belly distends noticeably before you forcefully yank out your knot, much to Aiko's displeasure and she screams from the pain of the forceful extraction.":"Stroking yourself wantonly, you pull out of her and dump the rest of your load onto her stomach, a few errant streams landing on her breasts and staining her hair.")+"\n\n":
	"You let out a loud moan when your climax finally hits you, "+(player.hasKnot(x)?"thrusting your knot just that bit deeper, to Aiko's pleasured moans and let your inhumanely large orgasm spill forth into Aiko's abused pussy and womb. Her belly begins to distend visibly, growing into an obscenely rounded bulge, but none of your cum can escape past your tightly sealing knot. You are locked together until after your orgasm ends and a few minutes thereafter, your knot too well lodged to just pull free. Once it begins deflating you forcefully yank out your knot, much to Aiko's displeasure and she screams from the pain of the forceful extraction.":"slamming your hips into her once more and letting your messy orgasm spurt into Aiko’s abused pussy. Her belly begins to distend visibly, growing into an obscenely rounded bulge before you pull out, your [cock] still firing streamers of semen through the air. Your hot spunk coats her body, leaving her thoroughly soaked through with your musky man-butter.")+"\n\n")
	+"You get up, brushing yourself off and collecting your armorName. Aiko looks up at you, her legs still splayed out in a lewd display, your cum spilling out of her vagina and pooling between her two cushiony ass cheeks on the ground.\n\n"
	+(flags[kFLAGS.AIKO_BALL_RETURNED] == 0 ?"<i>“You got what you wanted…”</i> she says, almost whispering. <i>“Now will you give me back my Ball?”</i>\n\n"
	+"You have no use for it, you reason, and she was a decent fuck, so you reach into your pouch and pull out the ball, haphazardly tossing it over. It lands in the sticky pool of cum forming between Aiko’s legs, a bit of it splattering up onto her thighs"+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? ", and for good measure, you hock a wad of spit onto it as well":"") +". ":"")
	+"You leave her to figure out how to untie herself as you head back for camp.");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	postRapeUpdate();
	player.orgasm('Dick');
	cleanupAfterCombat();
}

private function aikoRapeFuckAss():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var x:Number = player.cockThatFits(50);
	outputText("Your eyes trail lasciviously down the fallen priestess’s body, and finally come to rest on the plump cheeks of her ass, exposed by her immodest robes. Making up your mind, you reach down to pull off the lower portion of her robes away, bearing down on her to prevent her from struggling.\n\n"
	+"<i>“Wha, wait, no, what are you—“</i>\n\n"
	+(player.cor >= 50 ||player.hasPerk(PerkLib.Sadist) ?"You backhand her across the face, reminding her to shut up and be a good little whore if she wants her ball back.":"You give her a disciplinary tap, reminding her to sit still if she wants to get her ball back.")+" She shrinks away from you and obediently raises her plump hind quarters into the air, her tails rising out of the way, revealing her glistening slit and cute pucker. Giving her a firm exploratory slap on the ass, you turn almost giddy with delight as the pillowy cheeks ripple and jiggle for an extended period of time.\n\n"
	+"The large spiral-shaped tattoos adorning her ass seem to be the perfect place for you to grab hold of both cheeks as you run your [c] along her slit, getting coated in her slick juices in preparation. She lets out a soft whimper as she feels you push your [cock "+(x+1)+"] flush against her pucker, lowering her shoulders toward the ground and gripping the dirt.\n\n"
	+"<i>“Please be gentle…”</i> she says as the tight ring of flesh begins to expand around your tip. Her face turns a deep crimson as you sink the first inch inside her, squeezing her ample cheeks around your [cock"+(x+1)+"] and moaning needily.\n\n"
	+"[if (player.cockArea("+x+") >= 40)<i>“AH! N..no, no more, it’s not going to…iieah!”</i> She cuts off mid sentence as you easily sink another four inches into her. Not fit? Hardly, you tell her, giving her a firm spank. Her slutty asshole begs to differ, you say—it’s practically swallowing your dick!\n\n]"
	+"You give one last firm shove forward with your hips, forcing a cry from Aiko’s throat as she is finally speared "+(player.hasKnot(x)?"on your full length up to the knot, and that starting to spread her pucker rather wide.":"on the full length of your cock.")+" You’re barely able to control yourself as you squeeze her delicious ass, beginning to pump in and out with a reckless haste.\n\n"
	+"Aiko squeals, but from pain or pleasure, it is difficult to tell. "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "You find yourself hoping that it is the former, making a point of roughly abusing her ass for your own selfish pleasure. ":"") +"The way her rectum constricts your shaft is exquisite, the inner flesh feeling pillowy soft and warm as it ripples across your [cock"+(x+1)+"] with every thrust.\n\n"
	+"You lose yourself in the pleasure, your ears deaf to the lovely priestess’s cries as her ass is impaled on your rod again and again, pulling you closer and closer to climax with every thrust."+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? " Smiling vindictively, you lean over her, digging your nails into her back painfully as you pound her ass harder still, her pained yelps filling you with delight.":"") +" Finally, you can take it no longer, "+(player.hasKnot(x)?"shoving your hips forward with all your might and burying your knot in her ass as,":"")+" your shaft distending with cum as you begin to pour out your lusts into the girl’s abused fuckhole. "+(player.cumQ() >350 ?"Her belly begins to swell with your seed, gurgling audibly as you dump load after load into her innards. When your cock’s spasms finally end, she is significantly rounder and heavier than previously, weighed down by the enormous volume of semen you filled her with.":"")+"\n\n"
	+(player.hasKnot(x)?"You are held together for a while longer by your distended and sensitive knot, which only starts deflating after several minutes.\n\n":"")
	+"When you pull out, her ass makes a sloppy slurping noise around your shaft, a glob of jism spilling out after it and splashing to the ground. "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "Aiko lays in a puddle comprised mainly of her own pussy juices, tears, and shame, weeping softly. ":"") +"You stand and brush yourself off, giving the kitsune priestess a hearty smack on the ass"+
	(flags[kFLAGS.AIKO_BALL_RETURNED] == 0 ?", and "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "pull out her ball, smirking evilly as a despicable idea comes into your mind. You place the ball up against Aiko’s brutalized anus and push it in, eliciting another shameful groan from her throat. Well, she said she wanted it back, and now she has it, you think to yourself with a terrible grin as you set off for camp.":"gently drop her ball on the ground next to her, setting off for camp.") +"":" and set off back to camp."));
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	postRapeUpdate();
	player.orgasm('Dick');
	cleanupAfterCombat();
}
private function aikoRapeHumiliate():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("As you stand over the fallen priestess, your eyes stray to her lush, bushy tails and furry ears. The cute fox-girl’s defiant yet defeated expression only enhances your desire to make her your pet. Her expression takes on a slightly fearful tone when she notices the sinister smile that graces your face as you walk forward and kneel down over her.\n\n"
	+"<i>“W-what are you going to do? Whatever it is, please just make it qui-aaahhnnn…”</i>\n\n"
	+"She cuts off in mid-sentence as your fingers lightly stroke her ears, her neck twitching back involuntarily as her words turn to whimpers. You tell her that if she wants her ball back, she’ll behave like a good pet. After rubbing her ears and running your fingers through her soft silver-blonde hair for a few moments, Aiko looks up and gives you a tearful nod, hanging her head shamefully as she accepts your degrading treatment.\n\n"
	+"As you gradually begin to disrobe her, you pay special attention to her plush breasts and ever-stiffening nipples, grinning lasciviously as she begins to moan softly under your gentle ministrations. When your fingertips begin to drift down her spine, her low moans and pants slowly begin to turn frantic and fearful. The closer your hands move to her bundle of fluffy tails, the more labored her breathing becomes, and you slowly begin to put two and two together.\n\n"
	+"Teasing her, you begin to hover your hand over the collection of her tails, and she blurts out in protest, <i>“P-p-please, no! No one’s ever touched my tails before!”</i>\n\n"
	+"You "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "promptly slap her":"give her a small disciplinary tap on the nose") +", silencing the meager defiance—you let her know that "+ (player.cor <= 50 ? "for now":"") +" she belongs to you, regardless of her past experiences, especially if she ever hopes to get her ball back. Commanding her to get on all fours, the defeated fox girl can do nothing but obey as she hesitantly gets in position, blushing meekly"+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? " and tearing up":"") +" as she whimpers on.\n\n"
	+"<i>“Please...all I ask is that you be gentle with me.”</i>\n\n"
	+"You let her know that her request is duly noted, but only for as long as your will allows. Your hand finally makes contact, and the stroking begins, curious to fully test her sensitivity. You begin with a gentle motion, and Aiko’s reaction exceeds your wildest expectations. Her eyes roll back into her head as her tongue starts to loll out, body bucking and twitching in time with the rhythm of your strokes as she suffers through the telltale signs of a rapidly-approaching orgasm. It’s quite clear that she’s enjoying her treatment, but unfortunately for her, you are reaching the end of your mercy. You turn your gently-stroking palm into a "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "clenched fist":"firm grip") +" around one of the furry limbs, and Aiko arches her back in response, releasing a howl. Her confused yelps alternate between pleasure and pain, but as her dripping pussy begins to turn into a torrential flood, you can easily tell which feeling has higher priority. Her wetness drenches her thighs as her knees buckle, and she collapses onto the ground, unable to support her own weight from the convulsions brought on by her climax.\n\n"
	+"After her body finally stops twitching, Aiko lays utterly defeated,"+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? " meagerly crying in a pool of her own shame,":"") +"but you are far from finished. You turn her around so you can plant your lips firmly against hers, shoving your tongue down her throat and moaning lewdly into her mouth as your hand roughly grips the hair on the back of her head. You break your kiss only to begin breathing hotly into her ear, and as she melts from the brief moment of passion, you whisper promises that her pain will only give way to greater pleasure. Aiko, already broken by her shame, hangs her head and prepares herself to suffer through whatever it takes to get her ball back.\n\n");
	if (player.hasVagina()) {
		outputText("You pull her head back by her hair, standing over her with lust in your eyes as you lower your [pussy] toward her lips, ignoring her whimpers of protest. With a sudden, forceful shove, you press her lips against your [clit], letting out a moan as she reluctantly begins to lick at your slit. You slowly begin to force her down onto her back using the weight of your [hips], shifting your position to turn around once she is fully splayed on the ground so that you can lean down and grasp one of her tails.\n\n"
		+"She lets out a gasp into your crotch, shaking from the sudden sensations, and you grin [if (player.cor >= 50)evilly] as you are struck with a wonderful, terrible idea. Grinding your hips across her face, you begin to coil her tail up, aiming it toward her glistening twat, and with a cruel smirk, you force the fuzzy appendage inside. Aiko lets out a scream that vibrates through your core, and you begin to ride her tongue with a renewed vigor, your hands grasping her tail tightly and roughly pumping it in and out. Her pleasurable convulsions grow more and more erratic, and you have to clamp your thighs down against the sides of her head to keep her from bucking out from under you, determined not to let her deny you your own orgasm.\n\n"
		+"At last, the shamed priestess’s clumsy tonguing begins to bring your pleasure to a head, due in no small part to the uncontrolled thrashing caused from being brutally fucked with her own tail. Your fem juices soak her face at the same time as she experiences her own climax, filling the air with the musky scent of aftersex.\n\n");
		player.orgasm('Vagina');
	}
	if (!player.hasCock() && player.hasVagina())
		outputText("You shiver and slowly dismount, standing up and leaving the practically comatose kitsune splayed out pervertedly on the ground, soaked through with your combined juices.\n\n");
	else
		outputText("You shiver lightly, prepared to dismount, but a slight throbbing in your groin reminds you that you haven’t yet taken care of your male half.\n\n");
	if (player.hasCock()) {
		var x:int = rand(player.cocks.length);
		if (!player.hasVagina())
			outputText("You roughly drag her onto her back by the hair, ignoring the pained cries she lets out as you position yourself over her, head to toe, slowly lowering yourself down to pin her shoulders with your knees. Grasping one of her tails, you begin to coil it up, aiming it toward her glistening twat, and with a "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "cruel ":"") +"smirk you force the fuzzy appendage inside.\n\n")
		else
			outputText("You raise your hips and angle your [cock "+(x+1)+"] toward her mouth, pressing the head against her tightly pursed lips. Reaching down, you pinch her nose tightly, forcing her to open her mouth lest she suffocate, and she reluctantly begins swallow your mass[if (player.cocks["+(x+1)+"].cockThickness >= 3), gagging on your girth].\n\n"
			+"You begin to ramp up the ferocity of your pumping, both your [cock] in her throat and the tail pummeling her pussy, and Aiko lets out a scream that vibrates around the tip of your member.\n\n");
		if (player.cockArea(x) <= 50)
			outputText("You begin to ride her throat with an animalistic passion, your hands glued to her tail as you pound her mercilessly from both ends. She gurgles and twitches beneath you, desperately trying to catch her breath in between thrusts, and you have to tighten your thighs against the sides of her head [if (player.isHerm())again] to keep her from flailing around too much, feeling your orgasm begin to well up.\n\n"
			+"You let out a strong moan as you feel your pleasure begin to boil over, and thrust yourself down in one last time. Aiko gags on your [cock "+(x+1)+"] as the shaft begins to swell with the onrush of cum, and "+ ((player.cumQ() <= 150) ?"you fire a few sticky streamers down the convulsing passage, making her cough and sputter.":(player.cumQ() > 150 && player.cumQ() <= 350 ?"you unleash a thick wave of jism into her throat, making her choke and sputter as it begins to back up and foam around the corners of her mouth":"you flood her gullet with your thick, virile spunk, forcing so much down her throat that her belly begins to distend from the sheer volume of it."))+"\n\n");
		else
			outputText("You bear down on her forcefully, but as the girl’s struggles grow more and more desperate, you at last concede that you simply won’t be able to cram any more of your massive member into her throat. Displeased with her failure to perform up to your standards, you pull your shaft from her throat, giving her a moment to cough up a wad of precum, and then give her a "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "firm swat on the side of the face. If she’s too inept to please you with her mouth, then you’ll have to find another way for her to get you off...":"gentle smack on the behind, playing up your dominance by scolding her") +"\n\n"
			+"You move your shaft down in between the perky tanned globes of her breasts, instructing her to pleasure you with them like a good pet. She obediently raises her hands up to squash them against the sides of your [cocks], pressing and kneading them back and forth as she moans out in shameful ecstasy from the torture of you fucking her with her own tail. With a pleased nod, you return your attentions to punishing the little slut, thrusting her tail in and out of her sopping twat"+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? " with an unnecessarily cruel amount of force":"") +".\n\n"
			+"While it’s no deepthroat, the incredible softness of her near-flawless tit flesh rubbing against your [cocks] soon sends you over the edge. With a strong moan, you release her tail and move your hands to her breasts, taking control as you buck back and forth, "+(player.cumQ() <= 150 ?" finally releasing your load onto the fox-girl’s belly, smearing it with your scent":((player.cumQ() <= 350)? "pumping out a thick load onto her stomach that spills down her sides and soaks the ground":"shooting stream after stream of cum all across the fox-girl’s lower body, painting her with a thick and thorough layer of jism"))+".\n\n");
		player.orgasm('Dick');
	}
	outputText("You stand back to take a look at your handiwork,"+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? " taking a twisted pride in what you’ve done, smirking in satisfaction.":" feeling a little disgraceful about your cruel treatment of the poor girl as a nagging guilt descends in your gut.") +"\n\n"
	+(flags[kFLAGS.AIKO_BALL_RETURNED] == 0?"You decide that you should reward her obedience, pulling the ball from your pouch and smearing it in some of your leftover essences before "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "shoving it":"placing it gently") +" in her mouth, then petting and praising her as if she was a dog. You spot a few of her tails wag limply in response to your degrading treatment, her spirit broken, at least for now.":"You pet and praise her as if she was a dog, and spot a few of her tails wag limply in response to your degrading treatment. Her spirit is broken, at least for now.")
	+"\n\n"+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "Feeling immensely proud of yourself":"Feeling a bit disgusted with yourself") +", you turn and head back to camp.");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	postRapeUpdate();
	cleanupAfterCombat();
}
private function aikoFistHer():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("Making up your mind, you crack your knuckles with "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "sadistic glee":"a smirk") +". You’ve decided to punish her for all the trouble she’s caused, you tell her. She shrinks away, but runs out of room when she backs up to a tree, and you close in, trapping her easily. "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "You grab her roughly by the jaw and wrench her onto her back, the defeated priestess too exhausted to resist.":"You run a hand down the back of her head, stroking her ears, and slowly but firmly force down on the ground.") +" She begrudgingly resigns herself to being stripped down and tied up, and as you pull her robes away, you slowly run a finger across the little lotus tattoo that decorates her pubic mound, making her shiver.\n\n"
	+"As you slide your touch down further, you pull away with a thin string of her viscous fluids connecting your fingertip to her lady lips, and remark that she’s lucky. Her wetness will be of great assistance with what you have planned for her. You spread the dripping pink lips with one hand, and push two of your fingers inside with ease. Her quivering box lets out a small rush of juices in response, and as you begin to pump your fingertips into her, the proud priestess can’t help but let go of a low moan. Flexing your fingers inside her, you try to get a feel for her depths, and then gradually add a third, and then a fourth.\n\n"
	+"Reaching up with your other hand, you begin to grope and toy with her breasts, pinching the nipples and leaning up to suckle on them lightly. Your thumb rubs up against her engorged pleasure button as you twist and gyrate your fingers inside her, and she can’t help but release a shameful moan that sends her whole body into a twitching frenzy. You can tell that she is struggling with every fiber of her being not to rock her hips into your hand, trying to cling to her last shred of dignity.\n\n"
	+"Well, you can’t have your plaything having any of THAT, can you? You draw out to the very tips of your fingers and grunt with effort as you "+ (player.cor >= 50 || player.hasPerk(PerkLib.Sadist) ? "mercilessly":"firmly") +" shove your fist into her unsuspecting caverns. Aiko arches her back and practically freezes in place, every muscle tensed and shaking as her loudest moan yet shudders through her, all nine of her tails frizzing out like bottle-brushes. Her walls clench around your fist, instinctively wrapping around it like a fleshy glove, and a deluge of girlcum pours forth from her cunt, soaking your forearm. You scowl at her—the dirty bitch had the nerve to cum from just that?!"
	+"You begin to vigorously pump your arm into her, punishing her slutty cunt for daring to get off before you’re finished disciplining her. She begins to thrash wildly, unable to come down from her orgasm, and tears start to pour from her eyes from the tortuous constant pleasure. By now your arm is flying in and out of her, sending a new spray of juices flying with each thrust. You have little doubt anymore that she could easily take you up to the shoulder, but you’re trying to punish her. You knock the wind out of her with one last forceful thrust, and she tenses up into a second orgasm, rolling her eyes back in her head as she turns into little more than a mass of pure pleasure on the forest floor."
	+"When you pull back, your arm is thoroughly drenched, [if(player.hasFur())the [furcolor] fur matted down with her juices] and Aiko is still rolling from side to side in pleasure, her fuckhole gaping obscenely with the absence of your fist. You wipe yourself off on her discarded robes, flipping her onto her stomach and untying her as an afterthought, leaving the insensate kitsune to recover from her pleasure coma as you head back to camp.");
	postRapeUpdate();
	cleanupAfterCombat();
}
//maybe add tail fuck if naga or lizard tail? refer to KihaScene
private function aikoRapeGetLicked():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You grin at the fallen priestess, slowly stripping out of your [armor]"+(player.hasCock()?", lifting your [cocks] [if(player.balls > 0)and player.ballsDescriptLight()] out of the way":"")+" and displaying your [pussy] to her proudly. You explain to her that as the victor you’re entitled to the spoils, and what you want is her pride. To emphasize this fact, you place a hand on her head and begin to slowly stroke her head patronizingly.\n\n"
	+"<i>“S-stop treating me like I’m your pet d—”</i>\n\n"
	+"You silence her protest by thrusting her face into your pelvis, forcing her lips against your [pussy] with a moan. Too weakened and humiliated to resist, she only lets out a yelp at first and then resigns herself to begin running her velvety-soft tongue up and down your labia. Letting out a moan, you move your hands to the back of her head and force her deeper into your cunt with a crushing force, your juices dribbling down her chin freely.\n\n");
	if (player.hasCock()) {
		var x:int = rand(player.cocks.length);
		outputText("You take hold of her arm and lift it up, pressing her hand up against the side of your [cock"+(x+1)+"]. She seems to understand what you’re getting at, and instinctively begins to stroke back and forth, whimpering pathetically. [if (player.cocks.length > 1)Her other hand rises up to take hold of another of your shafts, and with a pleased smirk, you begin to grind your pelvis into her face eagerly.]\n\n"
		+"You pull her back by the hair for a moment and she lets out a gasp as she breathes in fresh air, her face drenched with your juices. Her cheeks are bright red, and you can tell that drinking in your scent and juices has aroused her quite effectively. She is still panting desperately when you shove her face-deep into your crotch again, riding her tongue eagerly as you rise ever closer to your orgasm.\n\n");
		player.orgasm('Dick');
	}
	outputText("She glares up at you "+(player.hasCock()?"[if (player.cocks.length > 1)between|around] your [cocks]":"")+", tonguing your [pussy] eagerly as her nine tails swish back and forth behind her. Regardless of any spite she may feel against you, her moans vibrate through your body, and it isn’t long before you can’t stand it any more. You bear down on her face with all your weight, drowning her in your slick girlcum, and she has no choice but to swallow it as quickly as she can. "+(player.hasCock()?"At the same time, your [cocks] swell with pleasure from her continuous stroking, releasing jets of cum that spray onto the ground behind her.":"")+"\n\n"
	+"You shiver with satisfaction and dismount her, giving her a light shove that she accepts easily, falling onto her back. Her face and the upper portion of her robes are drenched in your essence, mouth open wide and tongue hanging out. Her legs open in a shameful display, slightly twitching as a small puddle slowly spreads out from between them. Leaning down, pat her on the head and tell her she’s a <i>“good girl,”</i> chuckling to yourself as you pick up your [armor] and set off, leaving the priestess to her shame.");
	flags[kFLAGS.AIKO_BALL_RETURNED] = 1;
	postRapeUpdate();
	player.orgasm('Vagina');
	cleanupAfterCombat();
}

private function aikoSexMissionary():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var x:int = rand(player.cocks.length);
	outputText((playerchoice?"You tell Aiko that you want to do it the old-fashioned way today, slowly beginning to take off your [armor].":"<i>“Today... we’re gonna do it old-school,”</i> Aiko says matter-of-factly, looking you over with a lusty smirk as she begins to remove your [armor].")
	+"\n\nOnce you are fully nude, Aiko begins to disrobe herself, moving at a slow, sensual pace. She puts on a show, not quite a striptease, slowly tugging the sash that holds the lower half of her robes up and letting it fall to her ankles in a heap. Her upper robes follow soon after as she shoulders out of them, and she steps out of the pile of her clothes to step toward you. The last article of clothing to remove is her tight chest binding, which falls to ribbons on the ground, allowing her firm, silky tan breasts to jiggle freely.\n\n"
	+"The sight of her beautiful form standing nude in front of you has you rock hard already, and she places a hand on your shoulder [if (flags[kFLAGS.AIKO_AFFECTION]>64), looking deep into your eyes.|, giving you a slight smirk.] She begins to tug down on you lightly, leading you down toward the ground and laying herself flat on her back with her tails spread out beneath her.\n\n"
	+"Her legs spread out, revealing her glistening pussy lips, and she begins to play with her breasts and clitoris, preparing herself for you. Her fingertips slowly slide down your [allbreasts], then drift down to your groin, caressing your [cocks] lightly. She wraps her hand around your [cock "+(x+1)+"] softly and begins to rub the head against her netherlips, rocking her hips up to slide along it sensually.\n\n"
	+"Taking a firmer hold of your shaft with both hands, she lifts her hips up and pulls you down inside, letting out a husky moan. She rocks her hips forward again and again, each small motion pulling more and more of your hot man meat inside. You can feel her hips pressed up against you now, your [cock "+(x+1)+"] buried up to the hilt in her silky soft pussy, the muscular walls squeezing you skillfully.\n\n"
	+"Letting out a soft moan, you begin to move your hips, thrusting slowly and passionately in time with the lovely priestess. Her legs slide up to wrap around you, and she pulls you against her tightly, letting out a soft whimper of pleasure as she surrounds your body with her tails. Your sensibilities slowly succumb to baser instincts as you begin to increase the pace of your thrusting. Aiko doesn’t seem to mind it, though, as she grinds her hips up to meet you, raising her luscious ass off the ground a few inches in order to impale herself on you again and again.\n\n"
	+"[if (!player.isCentaur())You move your hands down her sides, groping at the delicious globes of her derriere lightly. The soft, jiggly cheeks feel incredibly plump and juicy, like perfectly ripened fruit, and you can’t help but let out a soft moan as the warm flesh spills over your fingers.\n\n]"
	+"You continue your vigorous pace, passionately plowing the beautiful fox girl, feeling her warm juices spilling out around your shaft with each thrust. Her moans become stronger with each passing moment, and the way her sopping, incredibly soft pussy is squeezing you now, you can tell that it won’t be long before you both are sent over the edge.\n\n"
	+"Her walls give one final muscular contraction, clamping down on your [cock "+(x+1)+"] with unbelievable tightness and pulling you in with an incredible suction. "
	+(flags[kFLAGS.AIKO_AFFECTION]>=65?"\n\nMoaning to the heavens, Aiko throws her arms around you and pulls herself up to kiss you passionately, screaming her pleasure into your lips as her body trembles and shakes.":"")
	+(player.hasKnot(x)?"\n\nYou ram your knot home and it swells to its full capacity, sealing her tight moments before your orgasm hits. ":"")
	+"Your shaft swells within her as you are thrown into your climax, "
	+(player.cumQ() <= 150 ? "you let out a loud moan as your climax finally boils forth, "+(player.hasKnot(x)?"shooting streams of cum into Aiko’s pussy and slumping over her until your knot starts shrinking. After a few minutes you pull out, making sure she is not hurt by your knot, though due to her being a kitsune she seems to have no problems with her stretchy snatch.":"shooting a few streams of cum into Aiko’s pussy, pulling out and letting the last few ropes spray across her stomach.")+"\n\n":
	(player.cumQ() <= 350 ? "spilling an incredible load into her pussy that bubbles up around your shaft, "+(player.hasKnot(x)?"but cannot pass your swollen knot. Aiko lets out a fevered moan as her belly swells and she realizes all the cum is trapped by your knot. A few minutes after your climax is done, your knot starts shrinking. After a few minutes you pull out, making sure she is not hurt by your knot, though due to her being a kitsune she seems to have no problems with her stretchy snatch. Some of the cum starts leaking out,":"and ")+"drizzling its way down her gorgeous ass.\n\n":
	" pumping load after load of seed inside her until her taut abdomen is swollen into a gravid, jiggling belly."+(player.hasKnot(x)?" None of the cum you just pumped into her can escape thanks to your swollen knot and Aiko collapses with you being pulled onto her hugely distended belly. You lie there few minutes after your climax is done, until your knot starts shrinking. After a few minutes you pull your knot out, making sure she is not hurt by the large bulbous mass, though due to her being a kitsune she seems to have no problems with her stretchy snatch. ":"")+"\n\n"))
	+"Her inner muscles still have not given up your member yet, and you lay over her, your pants and gasps mixing into a passionate symphony with hers. Once she has ridden the last waves of pleasure her orgasm will offer, she relaxes, unclenching her vaginal walls and slowly slipping down to relax on her back."
	+(flags[kFLAGS.AIKO_AFFECTION] >= 65 ? "You roll off her and collapse next to her on the ground, smiling and staring up into the leafy forest canopy. Turning toward you, Aiko leans in to plant a small kiss on your cheek and curls herself up to wrap against your side, resting her head on your shoulder. You cuddle with her like this for some time, but sadly, all good things must come to an end. With a somber tone, you tell her that you need to go back to check on your camp.\n\n"+
	"<i>“Okay,”</i> she says, still lounging naked in the grass as you collect your things. <i>“Don’t be a stranger.”</i>\n\n"+
	"You tell her you certainly won’t, taking in one last view of her lovely body before setting out.":
	(flags[kFLAGS.AIKO_AFFECTION] >= 50 ? "You push back from her, sighing with satisfaction, while Aiko continues to lay on her back, legs spread out lazily as she catches her breath.\n\n"+
	"Much as you hate to leave, you tell her that you really should be going back to check on your camp.\n\n"+
	"<i>“Hehe, see ya later then,”</i> she says, giving you a flirtations <i>“finger waggle”</i> wave, still lounging naked in the grass as you collect your things. You take one last look back to eye her nude body before setting out, catching a slight hint of sadness from her at the sight of seeing you go.\n\n":
	"As you pull back, Aiko sighs a bit, the expression on her face one of satisfaction mixed with a hint of self-loathing. Laying back on the ground, she looks up at you and says, <i>“Well... You’re not bad. Maybe you should try being nicer… if you behave yourself, we can do this more often.”</i>\n\n"+
	"She gives you a small wave as you gather your things and head back to camp, leaving her still lounging in the grass and staring contemplatively off into space.")));
	flags[kFLAGS.AIKO_SEXED]++;
	flags[kFLAGS.AIKO_AFFECTION] += 4;
	if (player.cor >= 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0)
		flags[kFLAGS.AIKO_CORRUPTION] += 4;
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]>0 && flags[kFLAGS.AIKO_CORRUPTION] >= 50 && player.cor <= flags[kFLAGS.AIKO_CORRUPTION]) {
		player.cor += 2;
		flags[kFLAGS.AIKO_CORRUPTION] -= 2;
	}
	if (player.hasStatusEffect(StatusEffects.Spar)) {
		player.removeStatusEffect(StatusEffects.Spar);
		if (player.hasStatusEffect(StatusEffects.DomFight))
			player.removeStatusEffect(StatusEffects.DomFight);
		cleanupAfterCombat();
	}
	doNext(camp.returnToCampUseOneHour);
}

private function aikoSexDoggy():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var y:Number = player.cockThatFits(50, "area");
	var x:Number = rand(player.cocks.length);
	while (y==x && player.cocks.length >1)
		x = rand(player.cocks.length);
	outputText((playerchoice?"You tell Aiko that this time, you want to take her doggy style.":"Aiko looks you over for a bit, an uncharacteristic lust in her eyes as her gaze lingers over your groin for a moment. <i>“Mn... I’m in the mood for something a bit ‘wild’ today... if you know what I mean,”</i> she says, giving you a coy smirk.")
	+"\n\nYou strip out of your [armor] eagerly, smiling as the lovely kitsune lowers herself down to the ground, reaching up to take hold of your [cocks]. Her hands begin to stroke and knead, and your shaft[if (player.cocks.length>1)s] soon grow[if (player.cocks.length==1)s] hard under her skillful technique. She gives the tip of your [cock "+(x+1)+"] a playful lick, and then changes position, moving down to her hands and knees in front of you with her luscious ass raised high in the air, tails fanned out like a peacock.\n\n"
	+"With a grin, you lower yourself down, placing your palms on the exotic spiral tattoos that adorn her heavy, jiggling butt cheeks and positioning yourself behind her. The tip of your [cock "+(x+1)+"] gently brushes up against her lady lips, and you can feel a veritable fountain of juices spilling out over it. You can see Aiko blush in embarrassment from how wet she is already, but she quickly deflects your attention back to her loins as she backs up onto your shaft a few inches, letting out a lewd moan.\n\n"
	+"The wonderful warmth of her insides wraps around you like a glove, and your hips fall forward involuntarily, "+(player.hasKnot(x)?"driving the full length of your shaft up till the knot":"driving every last inch of your shaft")+" inside in one stroke. Aiko’s mouth opens wide in a powerful moan, and she begins to rock her hips back and forth, slamming her bountiful bottom against your "+(player.hasKnot(x)?"knot":"hips")+" over and over again.\n\n"
	+"<i>“OOhh, yes, GODS, yes! I needed this so bad…”</i> she alternately yells and pants, working herself into a good rhythm. You move your hands up her sides to hold onto her hips, and her unrestrained ass cheeks begin to jiggle and bounce freely. Dropping forward onto her shoulders, Aiko reaches back and begins to fiddle with her clit while you continue to pound her pussy, and the rush of fluids that pours from her drooling gash begins to form a puddle on the ground.\n\n"
	//possible play with aiko tails on pc pussy
	+"<i>“Go, go go! Ah, yes!”</i>\n\n"
	+"You begin to worry if her yelps are going to attract a forest predator, but you push the thought away and resolve to focus on the task at hand.\n\n"
	+(y != 0 ?"While you passionately fuck her pussy, your [cock "+(y+1)+"] slides between her buttocks, significantly lubed up by the seemingly never-ending gush of fluids. Whenever you take a particularly long draw, it occasionally presses up against her pursed anus for a moment before moving along. Aiko looks back at you with a deep blush on her face and says, <i>“NN… ah! You can… Ooh! … If…. youuuUAuuh… want… F-fuck… my… a-ass, I m-meeeeeaAAhhn….”</i>"+"With her permission, you draw back and press up against her tight pucker, leaning forward to pierce her ass with your [cock "+(y+1)+"]! Aiko lets out a deep moan, wincing a little at first, but her warm innards are quite receptive to your shaft and her pain turns into pleasure within moments. Her anus begins to squeeze and suck you further in with every push, and the dual sensations of her holes drives you mad with pleasure.\n\n":"")
	+"Impaled on your shaft[if ("+(y+1)+" != 0)s], Aiko starts to buck back into you with redoubled passion, pressing her cheek into the grass as she continues to flick and squeeze her clitoris.\n\n"
	+(player.hasKnot(x) && player.hasKnot(y) ?"You slam home your knots into her pussy and tight ass, extracting a high pitched, excited screech from her throat at the overly stuffed sensation she is now being subjected to. Your knots swell and locks you thoroughly in place. ":(player.hasKnot(x)?"You slam home your knot into her pussy and she moans at the now very stuffed feeling in her pussy as your knot swells and locks you in place. ":(player.hasKnot(y) ?"You slam home your knot into her tight ass and she screams at the now very stuffed feeling in her ass as your knot swells and locks you in place.\n\n":"")))
	+"She cums HARD, and the effect is immediate and intense—her pussy [if ("+(y+1)+" != 0)and asshole] squeeze[if ("+(y+1)+" == 0)s] down on your cock[if ("+(y+1)+" != 0)s], and the heat inside her becomes almost unbearably pleasurable. You can’t hold back any longer, and have no reason to, squeezing her hips and thrusting with one final moan as you release your load inside her.\n\n"
	+(player.cumQ() > 350 ? "Her hole[if ("+(y+1)+" != 0)s] gurgle[if ("+(y+1)+" == 0)s] audibly as you pump your virile baby cream into [if ("+(y+1)+" != 0)both] her fuckhole[if ("+(y+1)+" != 0)s], feeling her abdomen start to swell up. She looks heavily pregnant by the time you finish dumping your load into her, letting her tongue loll out in pure bliss.\n\n":"")
	+(flags[kFLAGS.AIKO_AFFECTION] >= 50 ?"<i>“Th-that… was great…”</i> she says, falling forward "+(player.hasKnot(x)||player.hasKnot(y)?"and dragging you with her by your knotted cock before turning onto her side on the grass, both of you panting tiredly.\n\n":"off your cock[if ("+(y+1)+" != 0)s] to lay on her side on the grass. You follow soon after her, flopping down beside her with your arms splayed out tiredly, you both panting softly.\n\n")+
	(flags[kFLAGS.AIKO_AFFECTION] >= 65?(player.hasKnot(x)||player.hasKnot(y)?"She wiggles her ass tighter into you, still linked tightly by your knot":"She curls up against you")+", as all [if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0)eight|seven] of her tails wrap around you like a large blanket. She then presses her "+(player.hasKnot(x)||player.hasKnot(y)?"nose":"head")+" into your shoulder sweetly, closing her eyes. The two of you cuddle together on the grass for the remainder of the hour, but you finally have to tell her you need to go back to camp. "+(player.hasKnot(x)||player.hasKnot(y)?"You pull out of her, your knot finally having deflated and stand up. ":"")+"She waves goodbye, curling up underneath the tree and wrapping her tails around herself with a warm smile on her face.\n\n":
	(player.hasKnot(x)||player.hasKnot(y)?"You pull out of her, your knot finally having deflated and stand up. ":"You sit up slowly,")+" and tell Aiko that you should be heading back to camp soon. She nods in understanding, and then sighs a bit, curling up under the tree and wrapping her tails around herself.\n\n"):
	(player.hasKnot(x)||player.hasKnot(y)?"A few minutes later you pull out of her, your knot having finally deflated enough to allow it. ":"")+"She pulls away from you, dragging herself up into a seated position, and wraps her tails around herself, catching her breath.\n\n"
	+"<i>“Hah… hah… That… wasn’t half bad,”</i> she admits, smiling meekly. <i>“Maybe if you’re nice and behave yourself… I’ll let you do it again sometime.”</i>\n\n"
	+"You tell Aiko that you should be heading back to camp soon, and she nods, not saying another word.\n\n")
	+"Gathering your things, you put on your [armor] and head back to camp.");
	flags[kFLAGS.AIKO_SEXED]++;
	postSexUpdate();
	player.orgasm('Dick');
	if (y != 0)
		player.orgasm('Dick');
	if (player.hasStatusEffect(StatusEffects.Spar)) {
		player.removeStatusEffect(StatusEffects.Spar);
		if (player.hasStatusEffect(StatusEffects.DomFight))
			player.removeStatusEffect(StatusEffects.DomFight);
		cleanupAfterCombat();
	}
	doNext(camp.returnToCampUseOneHour);
}

private function aikoSexBJ():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var x:int = rand(player.cocks.length);
	outputText((playerchoice?"You tell Aiko you want her to pleasure you with her mouth this time, eagerly stripping down so you can get things started.":"Pulling you out of your [armor] and setting it aside, Aiko gives you a wry grin as she watches you with lust in her eyes. ")
	+"\n\nShe smirks as your [cocks] bob[if (player.cocks.length==1)s] up into view, looking up to you with a mischievous smirk as she wraps her fingers around your [cock "+(x+1)+"], beginning to stroke it gently. <i>“Mmm… you’re already so hard,”</i> she says, gently rubbing her cheek into your groin, moving her nose to the base of your [cocks] and taking in your scent.\n\n"
	+"She purses her lips against your base, sucking on the side of your shaft gently as her palm wraps around the head, squeezing drops of pre out and using them to lubricate her hand as she lavishes your [cocks] with passionate kisses and strokes. She pulls her hand away for a moment, summoning a pale blue flame into her palm, and returns it to your main shaft, coating it with cool wisps of fire that send shudders up your spine. "+(player.balls > 0?"Her other hand gently lifts your [balls], squeezing them softly as she runs her tongue up the underside of your [cock "+(x+1)+"].":"")+"\n\n");
	if (player.cockArea(x) < 40) {
		outputText("Her lips smack loudly as she plants kisses up and down your shaft, sending your senses into a frenzy as her hand works its way up and down your [cock "+(x+1)+"], dragging her fingertips along the length. [if (player.balls > 0)Cupping your player.ballsDescriptLight(),] Aiko gently glides her tongue up the underside of your shaft one last time, opening her lips into a wide O and engulfing you in her warm, moist mouth.\n\n"
		+"Keeping one hand wrapped tightly around the base, she begins to bob her head forward and back, letting your [cock "+(x+1)+"] hit the back of her throat with each gentle thrust. Her crystal blue eyes stare up at you coyly as she does so, her mouth curled into a smile around your quivering manhood. Pressing you against the back of her mouth, she swallows several times, the gentle rippling of her throat muscles massaging the head of your [cock "+(x+1)+"].\n\n"
		+"<i>“Mmm….. mm….”</i> Aiko moans softly into your cock, sending gentle vibrations down the shaft, and you can feel something bushy and soft begin to wrap around your legs. Her hands move around your [hips], where she digs her fingertips into the flesh of your [ass], and several of her tails coil tightly around your ankles and up to your thighs.\n\n"
		+"You hover your hands above her head momentarily, hesitating, but Aiko looks up at you with her glittering blue eyes and nods softly, her lips squeezing down tightly around your [cock "+(x+1)+"]. With her permission, you bury your fingertips in her silvery mane and begin to thrust your hips forward, driving your shaft down her throat. She moans, slurping and making lewd gulping noises as you start to throat-fuck her, her eyes rolling back a bit as spittle and precum begins to dribble down her chin.\n\n"
		+"Though she is making a good show of being letting you take command, you can feel her still bobbing her head rhythmically in your grip, her throat muscles contracting around your shaft strongly as she gulps down your throbbing meat. She’s definitely doing her share of the work, and you can soon feel your pleasure coming to a head.\n\n"
		+"Letting out an obscene moan, you lose yourself in pleasure as your [cock "+(x+1)+"] shoots hot ropes of semen into Aiko’s mouth, coating her throat with your virile jizz. She moans, closing her eyes, and presses her lips to the base of your shaft, her throat contracting rhythmically as she endeavors to swallow your load. "+(player.cumQ() >150 ?"She puts up a good effort, but ultimately fails as jets of cum spurt from the corners of her mouth"+(player.cumQ() >350 ?". As more and more of your semen cascades down her throat, her stomach begins to bulge a little, though far more of it gets on her than in her as it oozes messily down her chin":""):"")
		+(player.cocks.length>1 ?", the rest of your [cocks] spilling their spunk all over Aiko's chest and the ground below you":"")+"[if (player.hasVagina()), and your vagina spasming, dripping your excretions down the sides of your thighs and onto the ground, forming a messy puddle of combined sexual fluids]"
		+".\n\nOnce your orgasm is finished, she locks her mouth tightly around your deflating shaft and pulls back, squeezing the last bits of cum from your urethra and leaving your [cock "+(x+1)+"] clean as a whistle as her lips leave it with a soft smack. Using the corner of one of her sleeves, she cleans the remainder of your cum off her face, and then lets out a cute burp, patting her chest and saying <i>“Mn, oh, excuse me.</i>");
	} else {
		outputText("Her lips smack loudly as she plants kisses up and down your shaft, sending your senses into a frenzy as her hand works its way up and down your [cock "+(x+1)+"], dragging her fingertips along the length. [if (player.balls > 0)Cupping your player.ballsDescriptLight(), ] Aiko gently glides her tongue up the underside of your shaft one last time, opening her lips into a wide O and wrapping them around the head."
		+"Keeping one hand wrapped tightly around the base, her other hand begins to slide along the exposed portion of the shaft, while her warm, moist tongue slides out underneath the head. She slurps up each drop of precum enthusiastically, her crystal blue eyes staring up at you coyly as she does so, and her mouth curls into a smile as she begins to pump your shaft faster.\n\n"
		+"Squeezing your base tightly, she clamps down on your [cock "+(x+1)+"], causing your already engorged member to swell with the added pressure. She sucks on the head lavishly, allowing a mixture of spittle and precum to dribble down your shaft, which she gathers with her other hand to lubricate her strokes. One of her tails slides up to wrap around the base of your cock, constricting it tightly as it takes the place of her hand, and she begins to stroke you at a feverish pace using a double-fisted technique.\n\n"
		+"She giggles a bit at the look of pleasure that crosses your face, and redoubles her efforts, alternating between stroking you with both hands and kissing your shaft hungrily. The pleasure is getting to be too much to take, but her tail is blocking the only avenue for your release, and you can tell by her smirk that she knows exactly what she is doing to you.\n\n"
		+"Her hands continue to run up and down your [cock "+(x+1)+"] for what seems like forever, her tail wrapped tightly around the base to ensure that your release can never come, and all the while you feel your pleasure mounting higher and higher. You find yourself trembling from head to toe, begging her to let you cum, your muscles taut with the pressure of an orgasm that simply won’t arrive."
		+"<i>“Mn… Oh, I suppose,”</i> she teases, leaning back and pushing her chest out. One hand continues to stroke you while the other reaches behind her back, and you eye her lustfully as the bandages binding her breasts fall to ribbons, her gorgeous, perky breasts bouncing free. She opens her mouth and closes her eyes, and you can feel the grip of her tail suddenly loosen, your orgasm forcing its way to the top instantly."
		+"Letting out an obscene moan, you lose yourself in pleasure as your [cock "+(x+1)+"] shoots out hot ropes of semen all over Aiko’s face and chest, twitching like mad. Stream after stream spills out, several orgasms’ worth of cum finally allowed to fly free, making a thick, warm mess all over her face and breasts. "+(player.cumQ() >350 ?"Your orgasm seems to go on forever, and by the time it is all over, Aiko’s face is almost unrecognizable, hidden under a sticky mask of your cum.":"")+"\n\n"
		+(player.cocks.length>1 ?"The rest of your [cocks] spilling their spunk all over Aiko's chest and the ground below you"+(player.hasVagina()?", and your":""):(player.hasVagina()?"Your":""))+"[if (player.hasVagina()) vagina spasming, dripping your excretions down the sides of your thighs and onto the ground, forming a messy puddle of combined sexual fluids.\n\n]"
		+(player.cumQ() <= 350 ?" <i>“Mmmm...”</i> Aiko lets out a soft moan, swallowing the cum that landed in her mouth and beginning to clean herself off with the corner of her sleeve.":"<i>“Mn… You can stop now,”</i> Aiko teases, grinning girlishly as she sloughs off a layer of cum, giggling to herself. <i>“Damn, you made a mess,”</i>she adds, starting to clean herself off with the corner of her sleeve."));
	}
	outputText("\n\nOnce she is cleaned off, she gathers up her bandages and carefully begins to wrap her chest once more.\n\n"
	+"Pushing herself up to her feet, Aiko, brushes herself off a bit, her hips swaying back and forth gently.\n\n"
	+"<i>“Ah, that was fun,”</i> she says, stretching out and letting out a cute sigh.");
	flags[kFLAGS.AIKO_SEXED]++;
	postSexUpdate();
	player.orgasm('Dick');
	if (flags[kFLAGS.AIKO_TIMES_MET == 1])
		doNext(aikoE1SexPart2)
	else
		outputText("Once you have recovered from your satisfied stupor, you begin to gather your things, donning your [armor] again and bidding Aiko farewell as you make your way back to camp.")
	if (player.hasStatusEffect(StatusEffects.Spar)) {
		player.removeStatusEffect(StatusEffects.Spar);
		if (player.hasStatusEffect(StatusEffects.DomFight))
			player.removeStatusEffect(StatusEffects.DomFight);
		cleanupAfterCombat();
	}
	doNext(camp.returnToCampUseOneHour);
}

private function aikoSexCunni():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText((playerchoice?"You tell Aiko you want her to eat you out this time, eagerly stripping down so you can get things started.":"<i>“Pulling you out of your [armor] and setting it aside, Aiko gives you a wry grin as she watches you with lust in her eyes.")
	+"\n\nShe smirks a little as your [vagina] comes into view, running her tongue along the edges of her upper teeth. Her tails wrap around your ankles, and you find yourself on the receiving end of a playful shove. Your heart skips a beat, but you soon find yourself sliding down onto a blanket of writhing fox tails that catch you and lower you gently onto your back.\n\n"
	+"Aiko stands over you, undoing the sash that holds her robes together and letting them drop to the ground in a pile. Turning around, she lowers herself daintily across your prone form, giving you a good view of her supple ass cheeks and the red spiral tattoos that adorn them. Settling her head between your thighs, she presses her moist snatch against your lips, her tails moving beneath your neck to form a pillow. She wraps her arms around your thighs, lowering her lips to your quivering [vagina], while her tails lift your head up into her sweet-smelling honeypot.\n\n"
	+"She shivers lightly as you begin to run your tongue along the outside of the shaven lips of her lady flower, returning the favor as she moans into your crotch. Her tongue darts in and out of your folds skillfully, flicking your [clit] gently, and she wraps her lips around it, suckling lightly. Pleasure shoots up your spine, forcing you to moan into her dripping pussy, creating a feedback loop of pleasure as you go back and forth with her, trading licks and laps and kisses across each others’ pleasure zones.\n\n"
	+"Spreading your lips open with her fingers, she slides her tongue deep into your [vagina], the wriggling muscle burying itself in you. Her hips begin to hump against your face, smashing your nose up against her rear end, and she starts to lose herself in pleasure, coating your face in her slick love juices.\n\n"
	+"Moaning lewdly, she pulls her tongue back and begins to blow gently on your [clit], a cascade of blue flames pouring over your womanhood and sending shocks of pleasure throughout your body. She eagerly buries herself in your [vagina] again, sending her tongue darting over every fold and into crevice while her ample bottom pushes your head against the ground, jiggling as it bounces up and down on your face.\n\n"
	+"The two of you moan in unison, your quivering womanhoods clenching up tight, each drenching the other’s face in slick girlcum. Aiko’s legs tremble with pleasure, no longer able to hold her jiggling buttocks aloft, and she collapses onto you, her chin resting in between your thighs. Finally, she takes a deep breath and lifts herself off of you with what appears to be a monumental effort, gathers her clothes, and begins to tie her robes back on."
	+(player.cocks.length > 0?"Your neglected [cocks] spilling [if (player.cocks.length==1)its|their] spunk all over Aiko's chest and the ground below you":"")
	+"\n\nPushing herself up to her feet, Aiko, brushes herself off a bit, her hips swaying back and forth gently.\n\n"
	+"<i>“Ah, that was fun,”</i> she says, stretching out and letting out a cute sigh."
	+(flags[kFLAGS.AIKO_TIMES_MET] >1 ?"You can only nod your agreement as you lay there in satisfied exhaustion for some time, until you finally push yourself up and begin to gather your [armor]. Bidding Aiko farewell, you head back to camp.":""));
	flags[kFLAGS.AIKO_SEXED]++;
	postSexUpdate();
	player.orgasm('Vagina');
	if (flags[kFLAGS.AIKO_TIMES_MET == 1])
		doNext(aikoE1SexPart2);
	if (player.hasStatusEffect(StatusEffects.Spar)) {
		player.removeStatusEffect(StatusEffects.Spar);
		if (player.hasStatusEffect(StatusEffects.DomFight))
			player.removeStatusEffect(StatusEffects.DomFight);
		cleanupAfterCombat();
	}
	doNext(camp.returnToCampUseOneHour);
}

private function aikoSexTailjob():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var x:int = rand(player.cocks.length);
	outputText((playerchoice?"You ask Aiko if she can use her tails this time as you seductively let your [armor] slide off your body, exposing to the skittish kitsune your [cock "+(x+1)+"]. She instantly blushes and lowers her ears, aww.\n\n"
	+"<i>“I... W-we use our tails only with a person we really like... and I do like you...”</i> You see her progressively return to her usual self, spotting a mischievous grin as she guides you into a sitting position.\n\n":
	"<i>“I... really like you, [name], so I am going to do something we very rarely do, except to our closest companions and lovers.”</i> She seductively starts stripping your [armor], letting each piece fall to the floor and looking into your eyes before starting on the next piece, tracing her fingers along your shoulders, stomach and sides as she goes. As your [cock "+(x+1)+"] is exposed she gives a deep blush, drawing a finger down its' length and pulling away as soon as it jumps.\n\n")
	+"<i>“Just relax... and enjoy my fluffy tails, big boy.”</i> She says coyly as you see her [if (flags[kFLAGS.AIKO_BOSS_COMPLETE] >0)eight|seven] tails start moving and stretching out like the feathers of a peacock. You already feel hard just at looking at them.\n\n"
	+"Aiko climbs onto your legs and seductively crawls toward your face with a grin, she then passionately kisses your lips and searches for your tongue; her tails slowly caress your lower body with their soft, warm fur. You slowly encircle her with your arms as the kiss becomes more passionate, until you feel one of her tails wrapping gently around your [cock "+(x+1)+"].\n\n"
	+"The skittish kitsune giggles playfully, earning a soft moan from your throat. She gently caresses your ample rod, covering all of its length with one of her tails, moving it gently as you feel the warm fur enveloping you with a comfortable glow, like a camp-side fire caressing your cock.\n\n"
	+"You moan from the masterful touch of your kitsune lover, her tail will drive you to the edge very soon, it is so soft, luxurious and oh so dexterous! You kiss her profusely and you feel her crotch leaning onto your lower abdomen, covering it with female juice.\n\n"
	+"As the kitsune continues to torment your rod, you notice that a second tail has joined the action, encircling the tip of your [cock "+(x+1)+"] while the other one firmly remains wrapped around the base[if (player.balls > 0), caressing your balls]. "
	+((player.cocks.length>1) ?"The "+((player.cocks.length>2) ?"rest":"other")+" of your [cocks] are quickly enveloped and caressed by Aiko's tails, being subtly teased and rubbed by the feather-like silky fur of her tails"+(!player.hasVagina()?".\n\n":", and your"):(player.hasVagina()?" Your":""))
	+(player.hasVagina() ?" [vagina] is tickled by the continuous motion of the tail caressing your [if (player.balls > 0)balls|cock]. Occasionally one of her tails push against your mound, the silky texture feeling quite exquisite against your folds.\n\n":"\n\n")
	+"You blush and let a deep moan into Aiko's mouth as ecstasy envelops your body like an electric shot, your orgasm exploding onto her belly, breasts and the tails of your kitsune companion.\n\n"
	+"Aiko giggles as she stands covered in your hot, thick sperm. She then hides her mouth behind one of her soaked tails before seductively licking it clean, watching you panting with pleasure.\n\n"
	+"<i>“Few people get to enjoy my tails like this... and you definitely seem to appreciate it, [name]... next time, I'll see to it that you even the odds...”</i> She giggles as you pull her close for another kiss, earning a playful grin. Breaking it with a sigh, you tell her you have to return to your camp, but you promise next time you bathe her in pleasure.");
	flags[kFLAGS.AIKO_SEXED]++;
	flags[kFLAGS.AIKO_AFFECTION] += 4;
	if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]>0 && flags[kFLAGS.AIKO_CORRUPTION] >= 50 && player.cor <= flags[kFLAGS.AIKO_CORRUPTION]) {
		player.cor += 2;
		flags[kFLAGS.AIKO_CORRUPTION] -= 2;
	}
	player.orgasm('Dick');
	if (player.hasStatusEffect(StatusEffects.Spar)) {
		player.removeStatusEffect(StatusEffects.Spar);
		if (player.hasStatusEffect(StatusEffects.DomFight))
			player.removeStatusEffect(StatusEffects.DomFight);
		cleanupAfterCombat();
	}
	doNext(camp.returnToCampUseOneHour);
}

private function submitToAiko():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell her that you’re just itching for a little "+(player.findPerk(PerkLib.Masochist) >= 0 ?"release":"abuse")+", and you’re not really looking to fight her for it.\n\n"
	+"She scowls a little, her nose scrunching up a bit as she growls, <i>“It’s rude to ask lady for a fuck without offering a little foreplay in exchange.”</i>\n\n"
	+"You are worried she won’t take no for an answer, but thankfully she drops her billhook and walks up to you[if ("+"[hasweapon]"+"), gently taking your "+"[weapon]"+" from you and tossing it aside.] <i>“But I suppose it can’t be helped...”</i>");
	switch (player.gender) {
		case 1: doNext(aikoFootjob);
			break;
		case 2: doNext(aikoWhipping);
			break;
		case 3: doNext((rand(2)==0?aikoFootjob:aikoWhipping));
			break;
		default: outputText("Wait a minute! How am I supposed to have sex with you when you don't have any of the tools needed to even have sex?! Fuck off!");
			doNext(camp.returnToCampUseOneHour);
			break;
	}
}

private function aikoFootjob():void
	{
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	var x:int = rand(player.cocks.length);
	outputText("You fall back easily as Aiko shoves you to the ground, grinning smugly. She takes a twisted pleasure in slowly removing your armorName, punctuating her dominant position with an almost blasé approach to undressing you. When you are fully exposed to her “tender mercies,” she begins to drag her nails along your [chest], leaving behind a lingering sting that pushes a shamefully aroused whimper from your chest. Her tails snake out, twisting themselves around your arms and "+(!player.isNaga()?"legs":"naga tail")+" to hold you firmly in place. For good measure, another tail wraps firmly around your neck, not tight enough to restrict air flow, but seeming to serve as a warning if you were to resist.\n\n"
	+"<i>“Comfortable? I hope so,”</i> she says, her voice dripping with a sadistic venom.\n\n"
	+"She stands over you, raising one of her bare feet up to slide across your chest. Her toes slide down your body slowly, working their way gradually to your groin, and she skillfully uses her foot to lift your [cocks], flipping [if(player.cocks.length>1)them|it] back and pinning [if(player.cocks.length>1)them|it] against your body under her heel. In spite of walking around barefoot all the time, Aiko’s soles are silky smooth, and the feeling of her foot pressing into the underside of your shaft[if(player.cocks.length>1)s] is far more wonderful than you ever imagined. Her toes slide up to coat themselves in the pools of precum that are leaking out, wetting her entire foot with the slick fluid.\n\n"
	+"<i>“Heheh… you’re such a pathetic loser, getting off on something this.... You’re just a twisted perv, aren’t you?”,/i> she says with a grin, leaning down closer so that she can put more pressure on your groin. As her foot slides back and forth along the length of your [cock "+(x+1)+"], she begins to drag her nails along your chest and shoulders, eliciting a moan of pain and pleasure from your throat. <i>“Isn’t that right? You can talk a big game but you’re just a big masochist who gets off on having your dick rubbed up against my foot!”</i>\n\n"
	+(player.findPerk(PerkLib.Masochist) < 0 ? "Before you can protest, ":"")+"Aiko begins to increase the speed of her degrading footjob, kneading your groin firmly and forcing a weak groan from your throat. Tongues of vile purple flame begin to lick around her sole, coating your groin in an unbearable warmth. You cringe from the near-scalding heat of the flame, but your pain soon turns to pleasure. "+(player.findPerk(PerkLib.Masochist) < 0 ? "A look of horror graces your face as you realize that her flames are turning you into a masochist!":"")+"\n\n"
	+"The fuzzy bonds that hold you begin to constrict painfully, sending pleasurable spasms through you as the effects of Aiko’s flame spread over the rest of your body.\n\n"
	+"<i>“It’s wonderful, isn’t it? The pain… it’s just… exquisite… You want it don’t you? So, so badly…”</i>\n\n"
	+"Your body moves with a will of its own as you nod, thrusting your hips against her foot, shouting that yes, you want it, you’ll do anything!\n\n");
	if (rand(4)==0) {
		outputText("<i>“Hehehe, I guess next time you won’t be so selfish then,”</i> she says, pressing her foot down on your groin. No! You’re so close! If she would just keep stroking you for a little longer, you would be able to cum!\n\n"
		+"<i>“I told you, it’s rude to ask a lady to get you off and not offer a little foreplay in exchange,”</i> she says, echoing her sentiments from previously. She gives a slight huff and laughs at you vindictively, turning to leave you wallowing in your own pathetic shame as she disappears into the woods.\n\n"
		+"You grasp at your [cocks] and desperately try to finish yourself off, but your own furious strokes can’t seem to compare to the degrading ministrations of Aiko’s foot. With a growl of despair, you throw yourself back, realizing that ordinary pleasure just won’t be able to cut it for you until the effects of her flames wear off. You lay there for a long while before making your way back to camp, your painful arousal making it a bit awkward to walk the way your [cocks] [if(player.cocks.length>1)are|is] pressing up against the inside of your [armor].");
		player.dynStats("lus", 50);
	} else {
		outputText("<i>“That’s a good little masochist…”</i> she says quietly, wrapping [if(player.cocks.length==1)one of] her free tails around the base[if(player.cocks.length>1)s] of your [cocks] and constricting tightly like [if(player.cocks.length==1)a ]fluffy cock ring[if(player.cocks.length>1)s], increasing the speed of her rough stroking. Her toes curl around your [cock "+(x+1)+"], her foot becoming a blur as it vibrates across your [cock "+(x+1)+"] with a furious speed that would chafe if not for the copious amounts of lubrication acting as a buffer. The base[if(player.cocks.length>1)s] of your [cocks]distends as more and more cum pools into your shaft[if(player.cocks.length>1)s] below the tight grip of her tail[if(player.cocks.length>1)s].\n\n"
		+"Your [cocks] twitch[if(player.cocks.length==1)es] in vain as you feel load after load backing up inside you. Aiko laughs at your suffering, sliding her foot down to the base of your [cock "+(x+1)+"] and experimentally prodding at the swollen flesh. The feeling sends a shock of pleasure up your spine, and you begin to beg her to end this torment and let you cum!\n\n"
		+"<i>“Oh, fine, deny a girl her fun, you selfish little pervert,”</i> she says, grinning vindictively as her tail[if(player.cocks.length>1)s] recede, and at the same time she squeezes your shaft down with her foot, using the motion to aid your body in expelling your load. Your cum spurts across your chest, splattering up into your face with incredible force[if (player.balls > 0) as the contents of your balls empty themselves all over you].\n\n"
		+"Thoroughly coated in your own spunk, you lay on the ground as Aiko releases you from her grip. <i>“Mn… that’s a good look for you”</i> she says, rubbing her foot against your sensitive crotch some more and then turning to walk away. You lie in your own shame for a time before finally cleaning yourself off and gathering your things to return to camp.");
		player.orgasm('Dick');
		postSexUpdate();
	}
	flags[kFLAGS.AIKO_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}

private function aikoWhipping():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You fall back easily as Aiko shoves you down, grinning smugly. She takes a twisted pleasure in slowly removing your armorName, punctuating her dominant position with an almost blasé approach to undressing you. When you are fully exposed to her “tender mercies,” she begins to drag her nails along your [chest], leaving behind a lingering sting that pushes a shamefully aroused whimper from your chest. Her tails snake out, twisting themselves around your arms and "+(!player.isNaga()?"legs":"naga tail")+" to hold you firmly in place. For good measure, another tail wraps firmly around your neck, not tight enough to restrict your air flow, but seeming to serve as a warning if you were to resist.\n\n"
	+"<i>“Comfortable? I hope so,”</i> she says, her voice dripping with a sadistic venom.\n\n"
	+"She raises one of her hands and suddenly claws you across the cheek, your face stinging from the sharp slap accompanying it. As fresh blood begins to seep from the wounds and drip down your chin, Aiko grabs you by the "+ (player.hairLength == 0?"ear":"hair") +", holding your head back so she can run her tongue across your face. Her lips are stained cherry red from your blood, a small droplet dribbling from the corner of her mouth when she pulls away, flashing an evil grin.\n\n"
	+"Her hand rises up again, and you instinctively recoil from the expected slap, but it never comes. Instead, tongues of a sickly purple flame begin to dance across her knuckles, coating her fingertips in their eerie corrupted glow. You cry out in pain as she sticks her fingers against your chest, the hot flames searing and sizzling as she rakes them across you in a long drag. You scream out in pain as they burn, but suddenly become aware that you are moaning with nothing short of orgasmic pleasure! The pain is unbearable, but the more terrible it becomes, the more you lust for it, longing to feel more and more!\n\n"
	+"<i>“Mm... isn’t it wonderful? The pain... the exquisite, excruciating pain...”</i>\n\n"
	+"[if (player.findPerk(PerkLib.Masochist) < 0)With a look of horror, you realize that her flame is slowly turning you into a masochist! ]You can’t help but give a terrified nod of agreement, your vaginal juices already spilling out over the ground. Your lungs let out a shameless moan to accompany your quickly approaching release, but you trail off into a frustrated pant, realizing that Aiko is not quite ready to finish you yet.\n\n"
	+"With a malicious grin, she raises one of the tails that doesn’t bind your limbs, and brings it down to lash out at your [chest], grazing across one of your burns. Her tail feels like a whip, stinging your flesh, and the first lash is soon followed by another, then another. The brutal whipping brings you closer and closer to your climax with each blow, but Aiko shows her skill at torment, holding back just enough to keep you from going over the edge.\n\n"
	+"<i>“HAHAhaHA! Like it?! Love it?! Admit it! Under the surface you’re just a twisted maso-pig!!”</i>\n\n"
	+"You squeal, twitch, turn, and convulse underneath her torture, your body burning as if it is on the brink of the most incredible climax of your life. Every lash feels like it will be the one that will send you there, yet each time it fails to deliver. Your only solace is that the pleasure drags on and on — given the choice, you might well lay there for days taking her abuse, moaning like a bitch in heat.\n\n"
	+"A shrill moan rises from your throat as you feel like you are finally about to be given precious release, painful spasms of masochistic pleasure ripping through your body while a veritable fountain of girlcum spills from your loins onto the grass.\n\n"
	+"<i>“You want it? You want to cum so badly, don’t you?”</i> Aiko says with a vicious laugh, licking her lips hungrily.\n\n"
	+"You shout it to the heavens, yes, you want it, you beg her to let you cum, you’ll do anything!\n\n");
	if (rand(4)==0) {
		outputText("<i>“Good! Remember that feeling...”</i>\n\n"
		+"Your raucous moans die out suddenly as the glorious torment ceases, and you shiver with unfulfilled desire as the vixen releases you from her grip. Even the tiniest touch would be enough to send you over the edge, but your worn and battered muscles won’t move an inch! You plead with her desperately, your voice growing hoarse, but all she does is push your head back into the dirt with her index finger, whispering, <i>“Not today, my little masochist slut...”</i>"
		+"She leaves you helpless on the ground, motionless save for the needy heave of your [allbreast]. Letting out a pathetic whimper, you finally black out from exhaustion, your needs unmet.\n\n"
		+"When you come to about an hour later, Aiko is nowhere to be seen. Your muscles are agonizingly sore, and your body is still flushed with arousal, but you already know you’ll be a bit tougher for the ordeal.");
		player.dynStats("lus", 50);
		player.dynStats("tou", 2, "sen", -12);
		player.fatigue += 30;
	} else {
		outputText("<i>“Mmn, you’re lucky I’m feeling generous today my little masochist slut...”</i>\n\n"
		+"She grabs you by the throat and thrusts her lips against yours, forcing her tongue inside to clear the way as she exhales a bittersweet venom-purple flame into your mouth. The toxic taste of licorice cascades down your throat, and your pleasures are suddenly doubled over, at last pushed past your limit!\n\n"
		+"Every muscle in your body tenses up as your orgasm finally rips through you, reduced to a shameless, pathetic heap underneath your kitsune dominatrix.\n\n"
		+"<i>“Don’t say I never gave you anything,”</i> she whispers into your ear, gently licking a little dried blood from your cheek wounds. You simply black out from exhaustion, your whole body still shaking from the afterglow of the wonderful torture.\n\n"
		+"When you come to about an hour later, Aiko is nowhere to be seen. Your muscles are agonizingly sore, but you already know you’ll be a bit tougher for the ordeal.[if(player.findPerk(PerkLib.Masochist) < 0 ) You shudder a little, remembering with disgust how willingly you subjected yourself to this treatment.]");
		player.orgasm('Vagina');
		player.dynStats("tou", 2, "sen", -2);
		player.fatigue += 30;
		postSexUpdate();
	}
	flags[kFLAGS.AIKO_SEXED]++;
	doNext(camp.returnToCampUseOneHour);
}

/////////////////////////////////////////////////////////////////////
//////////////////////YAMATA INTERACTIONS////////////////////////////
private function yamataTalk():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	if (flags[kFLAGS.AIKO_CORRUPTION] < 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] <= 0) {
		outputText("You ask Aiko if there’s anything else she can tell you about her half-sister.\n\n"
		+"She sniffs, looking up at you from her place on the ground, and nods a bit, standing up to face you. Brushing herself off, she composes herself and says, <i>“We never really got along... I mean, it started as just general sibling stuff... but the day I was chosen to be the village guardian, I think that was just the last straw for her. We both had wanted the position our whole childhood, and when she was passed over...”</i>\n\n"
		+"Aiko snaps her fingers to emphasize her point, sighing sadly.\n\n"
		+"<i>“The night after I was inducted as guardian, Yamata broke into the shrine and stole one of the treasures our clan was protecting. She went on a rampage, and then before she could be subdued, she left without a trace. No one’s seen her since, until she showed up out of the blue, with my Ball in hand.”</i>\n\n"
		+"You ask if she can tell you anything about this treasure she stole, hoping to glean as much information as you can.\n\n"
		+"<i>“I don’t really know a whole lot about it, because it had always been kept under lock and key, sealed in the deepest parts of the shrine. There’s one thing I’m sure of, though; it’s a dangerous weapon in the hands of someone like her.”</i>");
	} else {
		outputText("She sighs, shaking her head a bit and making it very evident that her patience is wearing thin. There’s little she can do without your help though, so she says, <i>“We never really got along... Standard sibling rivalry crap... but the day I was chosen to be the village guardian, ohoh, she fuckin’ lost it. We both had wanted the position our whole childhood, and when she was passed over...”</i>\n\n"
		+"To emphasize her point, she takes her thumb and runs it along her throat, making a sick grimace.\n\n"
		+"<i>“The night after I was inducted as guardian, Yamata broke into the shrine and stole one of the treasures our clan was protecting. She went on a rampage, and I’m talking total carnage here, it was just beautiful! She disappeared without a trace, until she came up out of the blue, with MY Ball!”</i> she growls, baring her teeth.\n\n"
		+"You ask if she can tell you anything about this treasure she stole, hoping to glean as much information as you can.\n\n"
		+"<i>“Never really knew a whole lot about it—the elders were terrified of the thing, so it was sealed underneath the shrine. There’s one thing I’m sure of, though; it’s dangerous in the hands of someone like her. It’s just too bad I didn’t get my hands on it FIRST...”</i>");
	}
	//[Go Now][Prepare]
	menu();
	addButton(0, "Go Now", yamataStart).hint("Go with Aiko to take on Yamata and stop her madness!");
	addButton(1, "Prepare", yamataPrepare).hint("Go home and prepare, this will be a very tough fight!");
}

private function yamataPrepare():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell Aiko that you still need time to prepare, her half-sister is quite the adversary from how she described Yamata. You return to camp to continue preparations for the huge battle to come.");
	doNext(camp.returnToCampUseOneHour);
}

private function yamataStart():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("You tell Aiko you’re ready to go, asking her to lead you to the village now. She seems to perk up when she hears this, and nods.\n\n");
	if (flags[kFLAGS.AIKO_CORRUPTION] < 50 && flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] <= 0) {
		outputText("<i>“Okay, follow me,”</i> she says, taking your hand gently and pulling you along. She takes you from the clearing, leading you down a barely-visible dirt path. After a short walk, you spot a large wooden arch of strange design, seemingly erected in the middle of nowhere. It obviously has been maintained by someone, as its bright red paint shows little signs of fading and discoloration, but looking around, you can’t see any other signs of a civilization.\n\n"
		+"<i>“Stand here,”</i> Aiko says, walking up to stand in the arch. She reaches into her robes and pulls out a small paper talisman, placing it on the ground in the center, and stands back. With what seems to be a monumental effort, she summons up a small wisp of blue flame into her palm. Struggling with even the most rudimentary spells, it seems like her magic has been nearly depleted.\n\n"
		+"As she touches the flame to the paper, the entire archway is suddenly filled with the mystical fire, forcing you to shield your eyes from the blinding light. When the flames subside, you can now see a quaint village beyond the arch! Curiously, you walk the perimeter of the arch, and surely enough, the village is only visible when you are looking through the archway itself.\n\n"
		+"<i>“There’s not much time to explain,”</i> Aiko says with a hint of urgency in her voice. <i>“I just hope everyone’s still okay...”</i>");
	} else {
		outputText("<i>“Took you long enough to make up your mind,”</i> she says, taking your hand and pulling you along. She takes you from the clearing, leading you down a barely-visible dirt path. After a short walk, you spot a large wooden arch of strange design, seemingly erected in the middle of nowhere. It obviously has been maintained by someone, as its bright red paint shows little signs of fading and discoloration, but looking around, you can’t see any other signs of a civilization.\n\n"
		+"<i>“Stand here,”</i> Aiko says, walking up to stand in the arch. She reaches into her robes and pulls out a small paper talisman, placing it on the ground in the center, and stands back. With what seems to be a monumental effort, she summons up a small wisp of purple flame into her palm. Struggling with even the most rudimentary spells, it seems like her magic has been nearly depleted.\n\n"
		+"As she touches the flame to the paper, the entire archway is suddenly filled with the mystical fire, forcing you to shield your eyes from the blinding light. When the flames subside, you can now see a quaint village beyond the arch! Curiously, you walk the perimeter of the arch, and surely enough, the village is only visible when you are looking through the archway itself.\n\n"
		+"<i>“Quit gawking,”</i> Aiko says with a hint of impatience in her voice. <i>“Let’s just get in there and kick her ass!”</i>");
	}
	doNext(yamataIntro);
}

private function yamataIntro():void {
	clearOutput();
	spriteSelect(SpriteDb.s_yamata);
	outputText("The streets of the Kitsune village are deserted, and an eerie silence has settled over the town. Each house you pass is just as dark and empty as the last, and there’s not a single sign of any of the townsfolk. Just as you begin to think you might have been too late, you hear someone cry out in pain!\n\n"
	+"Rounding the corner, you find yourself face to face with an insane-looking kitsune, her foot pressing down on the back of one of the villagers. It looks as though she has been whipping the poor girl, but the blank eyes and ecstatic expression on her face show that her victim has been taking some form of twisted pleasure in the abuse. Now that you have had time to take in the scene, you can see that the town square has been converted into a makeshift bondage dungeon, and a number of townsfolk are strung up in chains and other crude restraints.\n\n"
	+"<i>“Yamata!”</i> Aiko calls out, clenching her fists.\n\n"
	+"<i>“"+ (player.catScore() > 0 ?"Well, well... look who the cat dragged in!":"Well, well... look who we have here...")+"”</i>\n\n"
	+"As you turn your attention to the kitsune with her foot on the villager’s back, you notice that her eyes are the same shade of blue as Aiko’s. Though hers shine with a terrible madness, and her mouth seems to be perpetually curled into a psychotic grin, showing her sharp, glinting teeth. She’s a good deal taller than Aiko, standing over 6 and a half feet tall, and sports a large pair of demonic horns sticking up in front of her ears. She has only a cloth chest wrap to cover her large E-cup breasts, her bare arms covered in scratches and bite marks, with a billowing pair of white pants flowing around her waist, similar in style to the lower portion of Aiko’s robes. You count nine large tails twisting in the air behind her, flicking around erratically. Her head is constantly turned at a slight angle, as if it’s been permanently screwed on wrong, and every move she makes is bizarrely unsettling, as if she were some kind of abomination wearing the form of a kitsune.\n\n"
	+"The most striking feature about her by far however, is her hair. A jet black mane cascades down around her shoulders, but as it flows down, it suddenly begins to twist outward, forming eight serpentine coils that curl around her, each ending in a large, fanged snake head. As she turns to address you both, all eight snake-heads turn their focus to you as well, snapping the air violently.\n\n"
	+"<i>“Looking for this?”</i> she says, grinning condescendingly as she twirls Aiko’s ball on her fingertip. <i>“I see you’ve brought a friend, dear sister. I hope you don’t think "+player.mf("he","she")+"’s going to save you!”</i> Grinning, she shoves her insensate victim aside with a foot, and begins walking toward you and Aiko. <i>“Of course, I can always use more toys for my pleasure... Mn... Yes, I think you’ll be the perfect addition to my playhouse... Champion.”</i>\n\n"
	+"You are taken aback when she mentions you by your title, and demand to know how she knows such things, trying to push back strange invading thoughts, creeping into your mind telling you how wonderful it would be to submit.\n\n"
	+"<i>“Oh, my master knows all about you... We’ve been watching and waiting for the right time to strike... To think I get to exact my revenge on my dear, sweet sister, turn this fucked-up village into my personal playground, AND finally get you out of the way all in one fell swoop!”</i> She raises her arms to the sky and begins to laugh hysterically, then finally snaps her attention back to you, licking her lips hungrily. <i>“You’ve been a thorn in our side for so long... What exactly do you have against a little anarchy? Chaos is what makes the world go ‘round! We’re all just bits of cosmic dust on the face of a worthless ball of mud anyway, crashing around the heavens in a perpetual outward spiral until we finally go out in one glorious, cacophonous universal heat death! Why not enjoy the ride, AM I RIGHT?!”</i>\n\n"
	+"Wow. This bitch really is crazy. You have no idea what she’s going on about, but you do know that you have to get Aiko’s ball back, and the only way that’s going to happen is if you defeat this woman. You ready your [weapon], preparing to fight.\n\n"
	+"<i>“Mn... that’s good, I like when my prey has a little bit of fight in them. Muramasa!”</i> she yells, holding her hand out to the side. A glowing circle adorned with runes appears in midair, and from it, she begins to draw a massive black blade that seems to be bathed in corrupted energy. The twisted weapon looks like something out of a nightmare, its straight edge curving forward into a sharp spike that looks like it could easily puncture even the most stout armors. <i>“Scared yet? You should be...”</i> she says, flipping the blade up onto her shoulder as a wall of corrupted fire begins to spread out from behind her, encircling the two of you and separating you from Aiko. It looks like you have no choice but to finish this fight!\n\n"
	+"<i>“[name]! "+(flags[kFLAGS.AIKO_CORRUPTION] < 50 || flags[kFLAGS.AIKO_CORRUPTION_ACTIVE]==0?"I... I believe in you!" : "Kick that cocky bitch’s ass!" )+"”</i>");
	startCombat(new Yamata());
}

public function yamataWins():void {
	clearOutput();
	spriteSelect(SpriteDb.s_yamata);
	outputText("You grit your teeth in pain as you fall onto your knees. As you fall, you can hear Yamata snickering at you. There's nothing you can do; she's simply too strong.\n\n"
	+"<i>“[name]!”</i> shouts Aiko as she runs towards your crumbled body. You can't help but curse yourself: you have failed her, you couldn't defeat her sister.\n\n"
	+"<i>“Come here, you little wretch!”</i> <i>“No! Let me go!”</i> As the fuss keeps going on, you manage to raise your head to see what's happening: Yamata has Aiko wrapped in her tails, firmly blocking every chance she has to escape. One of them also is in her mouth, blocking her speech. <i>“And shut up, you words are neither required nor welcome, hahahahaha! This is fantastic! Everybody will talk about me! “Yamata, the one who defeated the champion!” They want you alive... but I'd rather see you die in agony as I torture this little brat!”</i>\n\n"
	+"<i>“No! [name]! Please, don't leave me! NOOOOO!”</i> You are dizzy, and your head falls to the floor. You sight gets progressively blurred as you hear Aiko's screams of horror. You are grateful that you won't see her suffer any longer.\n\n"
	+"All you manage to mutter, as the life leaves your body, is a silent apology while a tear rolls on your cheek.\n\n");
	if (SceneLib.marbleScene.marbleFollower()) outputText("\n\n\"<i>NOOOOO! Sweetie!</i>\" Marble's cries carry from your camp.");
	CoC.instance.inCombat = false;
	EventParser.gameOver();
}

public function yamataLoses():void {
	clearOutput();
	outputText("You relax your shoulders as you see Yamata falling onto her all fours, desperately gasping with her evil eyes opened.\n\n"
	+"<i>“IMPOSSIBLE! You have such strength, "+(player.kitsuneScore() == 0 ? "for a lowly mortal!" : "even if you are weaker than I am!")+"”</i>\n\n"
	+"You coldly tell her to give it up, stop this demonic nonsense and return Aiko's ball. Yamata begins to laugh hysterically as you finish talking and then suddenly she shows her demonic visage to you.\n\n"
	+"<i>“Fool! How dare you to give orders to a nine-tails? People like you should be punished!”</i> As she threatens you, she quickly gets on her feet and tries to launch a jet black slash of energy at you. You ready your [weapon] and quickly slice the wave in half, letting it explode behind you, but as you look back, you find Yamata has vanished.\n\n"
	+"<i>“[name]! Pleas-”</i> Aiko's voice cuts the silence like a knife, you quickly raise your head and, in shock, you see that Yamata has captured Aiko and is entangling Aiko with her tails, one of them is in Aiko's mouth, preventing her from talking.\n\n"
	+"<i>“Hahahaahahaha! You lowly beings are so easy to trick! The tables have turned, it seems... “Champion”, leave this place if you want to live... but Aiko will be all mine...”</i> As she keeps threatening you, Yamata licks her sister's ear much to her shock and your dismay. With a quick bite onto Yamatas tail, Aiko manages to free her mouth,  the corrupted kitsune letting out a pained scream.\n\n"
	+"<i>“Don't worry about me, [name]! Attack her and stop this madness! She needs to be stopped!”</i> she pleas, but again Yamata's tail cuts her words short.\n\n"
	+"<i>“You insolent little brat! You will pay for that!”</i> Annoyed by her sister's tenacity, Yamata readies her Muramasa and tries to stab her right in the heart, but Aiko's distraction was all that you needed. While her attention was diverted, you moved close enough to reach the evil kitsune and her hostage, with a quick tackle with your shoulder to her side, you manage to free Aiko. As Yamata moves forward, you rapidly strike her with your [weapon], managing to force her down as Aiko falls onto her all fours, panting.\n\n"
	+"You stand over the defeated nine-tails who, with a grunt of rage, again tries to reach her Muramasa. You anticipated her and stomp down on her hand, pinning her down. With a quick movement, you snatch Aiko's ball from Yamata's cleavage, looking down on the defeated corrupted demon kitsune.\n\n"
	+"<i>“Damn you.... DAMN YOU! It was all the elders' fault! Everything I did was overshadowed by my stupid sister's accomplishments! Please... brave Champion... let me leave... I won't hurt you anymore, I swear...”</i> As you raise your [weapon] to deliver her the final blow, she looks at you with desperation in her eyes, tears rolling down her cheeks. She's clearly defenseless before you.\n\n"
	+"<i>“Don't listen to her, [name]... You should know it by now, kitsunes are masters of trickery... she's trying to manipulate you into let her get away! After all she's done to my village... even if she's my sister, she's a wretched demon.”</i> Aiko retrieves her ball from your hand and carefully hides it in her robes. With her powers now restored, she summons her bow and readies an arrow, aiming at her sister’s throat.\n\n"
	+(player.findPerk(PerkLib.Masochist) < 0 ?(flags[kFLAGS.YAMATA_MASOCHIST] >= 100 ?"You realize that from all the torture Yamata has put you through, you have come to enjoy pain quite a lot. <b>You have become a masochist!</b>\n\n":"All that pain Yamata put you through almost drove you to masochism, but you defeated her before she could manage to drive you to such depraved thoughts!"):"")
	+"You look at the defeated demon, with her eyes she's pleading mercy. You suppose you can let Yamata go, let Aiko finish her sister"+(player.cor > 60?", end her yourself or fuck her before deciding what to do.":"or end her yourself."));
	if (player.findPerk(PerkLib.Masochist) < 0 && flags[kFLAGS.YAMATA_MASOCHIST] >= 100)
		player.createPerk(PerkLib.Masochist, 0, 0, 0, 0);
	menu();
	addButton(0, "Let her go", releaseYamata).hint("Let Yamata go, trusting her to not hurt anyone else.");
	addButton(1, "Aiko finish", aikoKillSister).hint("It should be up to Aiko what to do with Yamata.");
	addButton(2, "Finish her", killYamata).hint("Yamata has caused enough pain and misery, end her now!");
	if (player.cor > 60) {
		addButton(3, "Fuck her", fuckYamata).hint("You can take some pleasure first before deciding on such tough matters, that fight got you really worked up!");
	}
}

private function fuckYamata():void {
	clearOutput();
	spriteSelect(SpriteDb.s_yamata);
	outputText("PLACEHOLDER TO FUCK YAMATA\n\n");
	menu();
	addButton(0, "Let her go", releaseYamata).hint("Let Yamata go, trusting her to not hurt anyone else.");
	addButton(1, "Aiko finish", aikoKillSister).hint("It should be up to Aiko what to do with Yamata.");
	addButton(2, "Finish her", killYamata).hint("Yamata has caused enough pain and misery, end her now!");
}
private function releaseYamata():void {
	clearOutput();
	spriteSelect(SpriteDb.s_yamata);
	outputText("<i>“What!? Are you letting her leave!?”</i> Turning her head towards you, Aiko wides her eyes, she really can't believe what you are saying.\n\n"
	+"You tell her she had her ball back and Yamata is now defenseless. Now that she knows your strength, she won't be bothering you anytime soon. Yamata looks speechless, but after that she giggles and looks at you.\n\n"
	+"<i>“You are more intelligent than you look Champion, maybe I will reward you for saving me from my sister's grasp... Such a shame, Aiko, it seems that this time I'm the winner, no?”</i>\n\n"
	+"<i>“SHUT UP!”</i> Aiko lets her arrow go, aiming for her sister's face, but before it can hit the corrupted kitsune, Yamata vanishes into dark energy and the arrow passes through the gap where Yamata just stood. The seven-tails stands speechless, her face a mask of rage. She grits her teeth and closes her fists.\n\n"
	+"<i>“I... I can't believe you let her go, [name]! She will come back! She will come back, she will try to destroy us again, can't you see how corrupted she is!?”</i> Aiko's anger masks a hint of sadness, her lucid eyes proves that. You try to reach her arm, but she quickly shrugs you off. <i>“Before she can come back... I will become a nine-tails and finish her off myself!”</i>");
	flags[kFLAGS.AIKO_AFFECTION] -= 20;
	player.dynStats("cor", 10);
	flags[kFLAGS.AIKO_BOSS_COMPLETE] = 2;
	doNext(yamataAftermath);
}
private function aikoKillSister():void {
	clearOutput();
	spriteSelect(SpriteDb.s_yamata);
	outputText("You look at Aiko from the corner of your eye and then you nod. She narrows her eyes and coldly releases the arrow. Yamata looks helpless as the projectile travels towards her face and widens her eyes as it pierces her throat. In agony, a look of pure hatred bursts on her face, directed at you and Aiko both as she gasps for air, drowning in her own blood. Finally Yamata collapses to the floor, as Aiko takes a deep breath of relief and closes her eyes.\n\n"
	+"The seven-tails then looks at you with trembling eyes and, without a word, she jumps towards you and wraps her arms and tails around you body. You smile and relax in her hold, returning the embrace. It's over, she's gone. <i>“I... had to do it... if she were to escape, she surely would have returned to haunt me or my village...”</i> She then looks in your eyes with eyes of gratitude and then she leaves you a long and tender kiss on your lips. <i>“Without you.. I would have been lost. Thank you, [name]”</i> she closes her eyes with a smile, blushing. <i>“I... need to get stronger. I need to become a nine-tails.”</i>");
	flags[kFLAGS.AIKO_BOSS_COMPLETE] = 1;
	doNext(yamataAftermath);
}
private function killYamata():void {
	clearOutput();
	spriteSelect(SpriteDb.s_yamata);
	switch(player.weapon.verb)
	{
		case "shot": outputText("You narrow your eyes and raise your [weapon] toward the defeated corrupted kitsune, Aiko and Yamata both widening their eyes in surprise. You then coldly release a shot directly into Yamata's chest, piercing her heart");
				break;
		case "slash":
		case "stab": outputText("You narrow your eyes and dash toward the defeated corrupted kitsune, Aiko and Yamata both widening their eyes in surprise. You then coldly stab the defeated opponent right to the heart");
				break;
		case "smash": outputText("crush the defeated opponent's ribcage");
				break;
		default: if (player.weapon.name.indexOf("staff") >= 0)
				{
					outputText("You raise your [weapon], letting out an immense blast of magic, engulfing Yamata and searing her flesh and crushing her windpipe. Aiko yelps in surprise and gives you a shocked look");
				}
				else
					outputText("You narrow your eyes and raise your [weapon] toward the defeated corrupted kitsune, Aiko Yamata both widening their eyes in surprise. You then coldly grab her by chin and the back of her head before twisting sharply and snapping her neck");
				break;
	}
	outputText(". Yamata coughs blood and murmurs a final insult before collapsing to the floor, dead. You then sigh in relief and lower your [weapon], turning to Aiko.\n\n"
	+"Before you can act, the seven-tails jumps in front of you and pulls you into a fierce hug. You smile and return the embrace of your kitsune lover, gently caressing her hair. After some time she pulls back enough to give you a long and tender kiss. <i>“It's over... I would have liked to finish her off myself, but who knows, she could have more tricks up her sleeve...”</i> She relaxes into your arms, looking at your face with a gentle smile and a blush on her cheeks. <i>“Thank you, [name]... if it weren't for you... I would have been dead.”\n\n“Therefore... I need to get stronger. I need to become a nine-tails!”</i>");
	flags[kFLAGS.AIKO_BOSS_COMPLETE] = 1;
	doNext(yamataAftermath);
}

private function yamataAftermath():void {
	clearOutput();
	spriteSelect(SpriteDb.s_aiko);
	outputText("Before you can go to free the kitsune townsfolk, your attention is drawn by the nefarious blade Yamata was using. “Muramasa”, you recall her naming it. You approach it cautiously, inspecting the blade closely: it's a black and sharp edged katana with deep purplish black swirls moving throughout the blade, it emits a very fierce corrupted energy, making you feel dirty by simply being near it. You think that this weapon may be too corrupted even for Rathazul to cleanse.\n\n"
	+"Aiko arrives and narrows her eyes, peering at the sword. <i>“This is a very powerful weapon... if ever it falls into demonic hands again, it will be disasterous... "+(flags[kFLAGS.AIKO_BOSS_COMPLETE] == 1 ? "Perhaps I can purify it with my magic" : "I can use it to locate Yamata, I think I'll be able to use it against her when I'm be ready")+".”</i> You stand still and watch Aiko grab the hilt of the katana and pull it out of the ground. You are tempted to warn her of its demonic influence, though she probably already knows more about the blade than you do, and can sense the taint regardless. She clearly understands the dangers of her actions.\n\n"
	+"After some time, you help Aiko free the townsfolk from Yamata's chains and bondage devices and twisted torture contraptions, everyone hailing you as a hero for the service done to the village. Some Kitsune even tempt you with their bodies, showing off her large breasts and seductive hips. It has been a long day and you remember that your camp is waiting. You kiss Aiko goodbye, promising to check on her later, but are stopped before you can leave by a nine-tailed kitsune who materializes before you. She is an absolute beauty, and has more than a few similarities with Aiko, albeit with more matured features.\n\n"
	+"<i>“Brave Champion, we thank you for the service done to our race... In the name of all of our village, you'll always be kept in the highest regards should you choose to return. I thank you, both as an elder and as a mother. Aiko seems to have found happiness with you, you have my thanks.”</i> Politely, the kitsune elder bows before you and then disappears seemingly into nothingness. You widen your eyes and recall Aiko's mention of her mother. No wonder Aiko is as beautiful as she is, having seen her mother."
	+"\n\nYou return to camp after an exhaustive day.");
	cleanupAfterCombat(camp.returnToCampUseFourHours);
}
  }
}