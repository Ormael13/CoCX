/**
 * ...
 * @author Liadri
 */
package classes.Scenes.Places.TempleOfTheDivine
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.Scenes.NPCs.Forgefather;
import classes.display.SpriteDb;

use namespace CoC;

	public class Onyx extends BaseContent {

		public function Onyx() {
		}

		public function onyxMF(boy:String, girl:String):String {
			return (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) ? girl : boy;
		}

		public function onyxName():String {
			return onyxMF("Onyx", "Krystal");
		}

		public function krystalonyxmenu():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("Waving over at [onyx name], you ask [onyx em] if [onyx ey] would feel like indulging in some quality time with you. [onyx Eir] eternal watch must get boring sometimes. [onyx Ey] fawns over you, clearly showing [onyx eir] interest.\n\n");
			outputText("\"<i>You're my savior and hero! How could I refuse such a request?");
			if (player.isGargoyle()) outputText(" There’s even a water source nearby to use as lube if necessary.");
			outputText("</i>\"\n\n");
			outputText("Being sure of what you both want, you proceed to a private room in the temple. You undress under the lusty gaze of [onyx name], who seems to devour you with [onyx eir] eyes, glowing with an intense desire. Once you're done, [onyx name] slowly proceeds to embrace you. Damn, [onyx eir] stone body is hot, and you can’t help but wonder if it's because [onyx ey]'s horny, or if it's the sunshine under which [onyx ey] basks all day long. This only arouses you more, and [onyx ey] slowly proceeds to ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2)
				outputText(player.breastRows[0].breastRating > 0 ? "mash her breasts with yours and gently push you" : "push her generous breasts on your chest and gently move you");
			else outputText("gently push you");
			outputText(" to the stone floor as [onyx ey] lowers a hand to your " + (player.hasCock() ? "[cock]" : "[cunt]"));
			outputText(".\n\n[onyx Ey] gently and slowly " + (player.hasCock() ? "strokes" : "fingers") + " you until you're quite aroused and nearly as hot as [onyx ey] is, fawning over you for some time, wanting you to feel [onyx eir] appreciation and affection while getting you ready for what comes next.\n\n");
			sceneHunter.print("Most scenes have variations for Gargoyle PC.");
			player.dynStats("lus", 50, "scale", false);
			//menu
			menu();
			addButtonIfTrue(0, "Tail Fuck", KrystalOnyxTailFuck, "Req. a vagina",
				player.hasVagina(), "Let's put [onyx eir] lovely tail to good use.");
			addButton(2, "69", KrystalOnyx69).hint("You wonder what [onyx eir] " + (flags[kFLAGS.ONYX_GENDER] == 2 || flags[kFLAGS.ONYX_GENDER] == 3 ? "cock" : "pussy") + "tastes like, and if [onyx ey] will return the favor.");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) {
				addButtonIfTrue(1, "Tribadism", KrystalTribadism, "Req. a vagina",
					player.hasVagina(), "Why not grind yourself on that lovely stone pussy.");
				addButtonIfTrue(4, "Fuck Her", KrystalFuckHer, "Req. a cock",
					player.hasCock(), "How about a feel of that rocky hole?");
			}
			if (flags[kFLAGS.ONYX_GENDER] == 3 || flags[kFLAGS.ONYX_GENDER] == 2)
				addButtonIfTrue(3, "Get fucked", KrystalOnyxGetFucked, "Req. a vagina",
					player.hasVagina(), "You’ve been eyeing that rock hard cock for a while.");
			addButton(14, "Back", SceneLib.templeofdivine.templeMainMenu);
		}

		public function KrystalOnyxTailFuck():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("Lying under [onyx em] you ask if [onyx ey] would like to penetrate you with that lovely tail of ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("hers. She");
			else outputText("his. He");
			outputText(" blushes for a moment, but agrees and slowly retracts [onyx eir] spikes until [onyx eir] tail is smooth and ready. [onyx Ey] lies on you, ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her stone breasts mashing against your chest as she");
			else outputText("His rock hard cock across your chest as he");
			outputText(" looks behind you both and slowly moves [onyx eir] tail toward your [cunt]. [onyx Ey] tickles your entrance for a moment with [onyx eir] tip, giving you a cute smile and making you gasp as [onyx ey] slowly inserts [onyx eir] tail into your snatch. You grow more aroused as [onyx ey] proceeds deeper and deeper until [onyx ey] reaches your cervix. You're filled so perfectly by [onyx eir] tail, despite the fact [onyx ey] is not moving the warmth and girth of [onyx eir] stone tail alone is enough to make you gasp.\n\n[onyx Ey] starts to slide [onyx eir] tail in and out of you, taking [onyx eir] time to tickle every sensitive spot inside your moist depths. [onyx Ey] seems to enjoy this as well since [onyx ey] moans lustily, and you assume that it's very likely in [onyx eir] former form [onyx ey] had developed a fetish for tail fucking to the point [onyx eir] tail is as responsive as a man's penis.\n\nSince [onyx ey] seems to be getting off on [onyx eir] own, you allow yourself to focus your mind on your own pleasure as [onyx ey] slowly but certainly brings you to the edge. A few seconds later you are both orgasming in perfect synchronization as you squirt all along [onyx eir] tail length. With a content smile you doze off next to [onyx em] in a scene of lovemaking fit for a master artist to paint in a fresco.\n\nYou wake up a while later and redress, heading back to camp.\n\n");
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}

		public function KrystalTribadism():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("Krystal's pussy looks like it could use some attention and so does yours. You slowly push the gargoyle down on her back as you begin to grind your pussy against her nether lips. With the lubrication of your feminine juices, her smooth stone pussy soon becomes as slippery as wet ice, and grinding yourself on it is even easier than it would be with a woman made of flesh. ");
			outputText("both of you moan like cheap whores as your clits engorge from the repeated motions. You begin to grope Krystal's breasts, which are surprisingly malleable despite her stone skin, making her gasp in pleasure as she grabs your [breasts]. Seems she enjoys it just like any normal woman would, despite her stony body.\n\n");
			outputText("Soon you climax ");
			if (player.isGargoyle()) outputText("and petrify along with Krystal, both of your bodies frozen in place for some time. You regain consciousness a while later and give her still frozen form a parting kiss as you head back to camp.\n\n");
			else outputText("and cover Krystal's stone pussy with your girl cum. Krystal petrifies from the orgasm, frozen with an expression of extreme pleasure as you doze off on your statuesque lover. When you wake up, you give her still frozen form a parting kiss as you head back to camp.\n\n");
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}

		public function KrystalOnyx69():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("Your eyes zero in on ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("Krystal's smoothly shaped pussy");
			else outputText("Onyx's perfectly carved cock");
			outputText(" and you start to ponder what a gargoyle tastes like. Determined to get the answer to this very important question, you tell [onyx name] to lay on ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("her back. She");
			else outputText("his back. He");
			outputText(" is quick to comply, and you take your time to position your genitals right above [onyx eir] face and ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("give her pussy a quick lick. She");
			else outputText("give his glans a quick lick. He");
			outputText(" moans in appreciation and responds by firmly grabbing your ass ");
			if (player.hasVagina()) {
				outputText("and filling your [cunt] with [onyx eir] stony tongue");
			}
			if (player.hasCock()) outputText("and suckling on your cockhead.");
			outputText(" You moan in delight and proceed to reward [onyx eir] effort with");
			if (player.hasVagina()) outputText(" pussy juices.");
			if (player.hasCock()) outputText(" precum.[onyx Ey] strangely doesn't have a bad taste, albeit very different from a creature of flesh and blood.\n\n");
			if (player.isGargoyle()) {
				outputText("You pleasure each other for several minutes, both of your stone tails flailing wildly from the impending orgasm. Your moans get louder and louder until you finally freeze in place at your shared climax, prolonging this perfect moment for what looks like a passionate eternity. When you come to your mouth is where you left it, and you decide to pull it off [onyx name]'s genitals. [onyx name] is still petrified in pleasure, ");
				if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("she");
				else outputText("he");
				outputText(" likely will come to later.");
			}
			else {
				outputText("You pleasure each other for several minutes as you try to match your tempo with that of your stony partner's. Soon you orgasm ");
				if (player.hasCock()) outputText("blowing your load in [onyx name]'s waiting mouth");
				if (player.hasVagina()) outputText("[onyx name] drinking the flood of your juices and licking your pussy clean");
			}
			outputText(" You doze off tired and wake up an hour later, your mouth still where you left it. You resolve to pull it off [onyx name] who, still petrified in pleasure, will likely come to later.\n\n");
			outputText("For now, you proceed to redress and head back to camp.\n\n");
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}

		public function KrystalOnyxGetFucked():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("The moment you made [onyx name]'s perfectly defined shaft you knew you would use it! You begin to slide your hand against [onyx ey] perfect pillar of maleness in order to wake it up. [onyx name]'s reaction is immediate as [onyx ey] cock grows erect within seconds, as hard as diamond and ready for your use");
			if (!player.isGargoyle()) outputText(". Well, not so ready yet... there's still the need for lubrication");
			outputText(". You lower your head and proceed to suck on [onyx name]'s perfect cock");
			if (!player.isGargoyle()) outputText(", liberally coating the entire length with your saliva");
			outputText(". [onyx name] shivers in delight at your expert cocksucking, but you’re not done yet. You move yourself into position and slowly begin to insert the hard tool inside your [cunt] ");
			if (player.isGargoyle()) {
				outputText(" moaning in delight at the perfect grinding of [onyx eir] perfectly shaped stone dick in your stone pussy wich begins to heat up from the friction");
			}
			else outputText("gasping as the cold hard stone enters you");
			outputText(".\n\nIt’s obvious [onyx name] had a lot of experience using a cock before, likely from [onyx ey] past life as the Obsidian Gargoyle. [onyx Eir] talent at fucking rivals that of the demons, and soon you find yourself at the mercy of [onyx ey] perfect gargoyle cock. [onyx Ey] pushes you on your back and takes charge, fucking your pussy so well that your eyes cross and your tongue falls out of your mouth as you pant in lust.");
			if (player.breastRows[0].breastRating >= 1) {
				outputText(" You barely register ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("him");
				outputText(" grabbing your breasts and caressing them with expertise as you are now entirely focused on the indescribable sensations coming from your pussy that threaten to break your mind.");
			}
			outputText("\n\n");
			if (player.isGargoyle()) {
				outputText("Soon [onyx eir] skill proves too much for you, as you lose it entirely to pleasure. Your mind regressing to that of an animal in heat, reaching nirvana several times over, screeching your bliss to the heavens. Your mouth gapes wide open as [onyx name] reaches [onyx eir] peak, both of you petrifying in a silent orgasmic scream. You stay there under ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("him");
				outputText(" for hours, untouched by time, until you recover mobility then push [onyx eir] still frozen form off you. Wow, what a fuck! If you didn’t know any better, you think you might get addicted to [onyx eir] dick.\n\n");
				outputText("You head back to camp, giving the unconscious gargoyle a parting kiss.\n\n");
			}
			else {
				outputText("Soon [onyx eir] skill proves too much for you, as you lose it entirely to pleasure. Your mind regressing to that of an animal in heat, reaching nirvana several times over, you scream out your bliss, splattering Krystal's/Onyx's cock with a constant waterfall of girl cum which only serves to accelerate and ease [onyx eir] pumping. You are still drooling on the ground as [onyx name] reaches [onyx eir] peak, petrifying in a silent orgasmic scream. You stay there under ");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("her");
				else outputText("him");
				outputText(" for several minutes as you calm down and recover your senses, then push [onyx eir] still frozen form off of you. Wow, what a fuck! If you didn’t know any better, you think you might get addicted to [onyx eir] dick.\n\n");
				outputText("You head back to camp, giving the unconscious gargoyle a parting kiss.\n\n");
			}
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}

		public function KrystalFuckHer():void {
			clearOutput();
			spriteSelect(SpriteDb.s_sapphire);
			outputText("Krystal sure has a lovely body, you can’t deny that. Her breasts are perfectly shaped, her face could make any man fall for her and that pussy looks so inviting it would be impossible to say no. You slowly push Krystal to the ground ");
			if (player.isGargoyle()) {
				outputText("readying your [cock] for the smoking hot gargoyle ");
				if (flags[kFLAGS.ONYX_GENDER] == 1) outputText("girl");
				if (flags[kFLAGS.ONYX_GENDER] == 2) outputText("herm");
				outputText(" before you.");
			}
			else outputText("making sure to lube your [cock] liberally to compensate for the lack of lubricant.");
			outputText(" You kiss Krystal, tasting her tongue with yours as you caress her breasts. She coos in delight, her tail waving from side to side as you slowly insert yourself in her stony, yet very malleable and accommodating, pussy. It's like the thing was made with an imprint of your dick, it hugs your shaft perfectly. ");
			outputText(" You moan in pleasure as you start to fuck the lusty gargoyle, enjoying the ministrations of her perfect pussy on your cock. You both make for the perfect match, and soon you find yourself on the verge of climax.\n\n");
			if (player.isGargoyle()) {
				outputText("You orgasm together in a climax so perfect that you petrify and lose the ability to move or think straight. You realise you’re still bottomed out in her, but you don’t care. You wish this perfect moment would last forever as you are kept at the peak of orgasm. Eventually the pleasure recedes, and both of you regain movement. ");
				outputText("If Krystal could blush she would, as she slowly removes herself from your now flaccid tool, looking like she had the orgasm of her life.\n\n");
				outputText("\"<i>Wow uh... [name] you sure do have excellent stamina.</i>\"\n\n");
				outputText("You redress and head back to camp utterly satisfied.\n\n");
			}
			else {
				outputText(" You cum, filling the gargoyle with creamy whiteness as both of you orgasm, Krystal momentarily losing its ability to move, petrified by pleasure. You begin to remove your dick from the gargoyle pussy but discover to your annoyance that her frozen cunt is so tight you have to almost forcefully open her snatch to get yourself loose. ");
				outputText("Eventually, an hour later you manage to slide out, a massive trail of cum following suit as you kept fucking her in your attempt to get free from her stony snatch.\n\n");
				outputText("You proceed to redress and head back to camp.\n\n");
			}
			player.sexReward("no");
			doNext(camp.returnToCampUseOneHour);
		}

		public function makingNewGargoyle():void {
			if (flags[kFLAGS.ONYX_GENDER] >= 1) makingNewGargoylePart4();
			else makingNewGargoylePart1();
		}

		public function makingNewGargoylePart1():void {
			clearOutput();
			outputText("Thinking about your lonely friend up there, you look at the spare gargoyle body and take the Black Soul Gem out of your pack. Maybe she could use the company of another gargoyle.\n\n");
			outputText("Everyone deserves a second chance, but you ponder if using the soul of a formerly sex-starved aberration is a bright idea.");
			menu();
			addButton(0, "Yes", makingNewGargoylePart2);
			addButton(1, "No", SceneLib.templeofdivine.templeBasement);
		}

		public function makingNewGargoylePart2():void {
			clearOutput();
			outputText("You work for six hours, sculpting the spare statue parts to your liking with an artist's passion, then head back to camp for a break.");
			menu();
			addButton(0, "Female", makingNewGargoyleFemale);
			addButton(1, "Herm", makingNewGargoyleHerm);
			addButton(2, "Male", makingNewGargoyleFMale);
		}

		public function makingNewGargoyleFemale():void {
			flags[kFLAGS.ONYX_GENDER] = 1;
			doNext(camp.returnToCampUseSixHours);
		}

		public function makingNewGargoyleHerm():void {
			flags[kFLAGS.ONYX_GENDER] = 2;
			doNext(camp.returnToCampUseSixHours);
		}

		public function makingNewGargoyleFMale():void {
			flags[kFLAGS.ONYX_GENDER] = 3;
			doNext(camp.returnToCampUseSixHours);
		}

		public function makingNewGargoylePart4():void {
			clearOutput();
			outputText("You conduct the ritual according to the book, carrying the statue to the altar and mixing your own blood with the ingredients as to carefully bind the new gargoyle to you, in case it’s soul is unstable. You draw the required arcane circles around the statue under the gaze of Sapphire. Once done, you place the Black Soul Gem on the altar and chant the arcane words.\n\n");
			outputText("\"<i>Shira Khrim Almisry Ohm Ak Tar Marae Kann Tharr Shul Elysro An Siryr Ahn Ekatyr Evenar Sethe Omaris!</i>\"\n\n");
			outputText("As you chant the last word, the gem seems to be assimilated directly into the " + (Forgefather.material) + " body, disappearing without a trace. The statue's eyes start to dimly glow with a pale purple light as the new gargoyle awakens with a surprised expression. \"<i>What happened...? I was dead, finally destroyed by your hands and at rest. But now I’m alive again. My thoughts free of the constant plague of sexual desires, and in a new body. Am I to be given a second chance?</i>\"\n\n");
			outputText("You start by asking the gargoyle for its name, not desiring to force it into the role of a slave again.\n\n");
			outputText("\"<i>My name?... While I used to be one soul, I am now many. Since I'm a living statue and I’m closer to a ");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("female");
			if (flags[kFLAGS.ONYX_GENDER] == 3) outputText("male");
			outputText(" being, I guess I’ll name myself [onyx name]. Are you going to be my master from now on?</i>\"\n\n");
			outputText("You have no intention of being such a thing, and you clearly state to [onyx name] that the only order you'll ever give [onyx em] is to help Sapphire guard this temple from potential corrupted influences such as demons and minotaurs. For the rest of [onyx eir] time, [onyx ey] is officially free to act and live as [onyx ey] wishes, without the constraints of obedience to a master. [onyx name]'s face would shed tears if it could, after living for years as a slave to a demon master, the freedom you offer the gargoyle is something it only dared to dream of.\n\n");
			outputText("\"<i>If that's the condition, then I will do as you ask. Thank you so much for everything, and should you ever need anything special, I will be here in the temple for you. It feels so good to finally be able to make my own choices again.</i>\"\n\n");
			if (flags[kFLAGS.ONYX_GENDER] == 1 || flags[kFLAGS.ONYX_GENDER] == 2) outputText("She gives you an affectionate kiss on the cheek, surprising you, then flies to perch on a nearby pedestal and begins her watch.");
			else outputText("He warmly hugs you to show his appreciation, then flies to perch on a nearby pedestal and begins his watch.");
			outputText("\n\n");
			flags[kFLAGS.ONYX_PATH] = 2;
			player.removeKeyItem("Black Soul Gem");
			doNext(camp.returnToCampUseOneHour);
		}
	}
}