/**
 * ...
 * @author Zevos
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.Places.HeXinDao.IgnisArenaSeer;

	public class IgnisArenaSeerScene extends HeXinDaoAbstractContent
	{
		public function IgnisArenaSeerScene() 
		{}
		
		public function mainIgnisMenu():void {
			clearOutput();
			outputText("You walk up to Ignis, waving in greeting. ");
			if (flags[kFLAGS.IGNIS_ARENA_SEER] == 1) {
				outputText("You notice that the kitsune has changed out of his traveling gear. He is wearing a loosely fitting men’s kimono, the grey cloth complementing his white fur. His staff lays to the side,should he need to defend himself at a moment’s notice. ");
				flags[kFLAGS.IGNIS_ARENA_SEER]++;
			}
			outputText("He gives a short wave in return, motioning for you to sit next to him.  As you approach, Ignis clears his bag off the bench, making room for you.  \"<i>Hello, [name], what brings you to the arena today?</i>\"");
			menu();
			addButton(0, "Appearance", ignisAppearance);
			addButton(1, "Talk", ignisTalks);
			addButton(3, "Sparring", sparringWithIgnis);
			addButton(4, "Leave", heXinDao.soularena);
		}
		
		public function ignisAppearance():void {
			clearOutput();
			outputText("Ignis is a kitsune, of the more animalistic variety.  He has a fox’s head with an angular jawline, adorned by a white pelt and covered by an unkempt mane of silvery hair.  Ignis’ slitted yellow eyes have a maniacal light to them. If you didn’t know better you would believe there was flame burning within them. His lower body is concealed by his flowing grey kimono, but from the way his kimono hangs off him you can see that he has a lithe form with little muscle, and a flat chest.  ");
			outputText("His hands are pawlike, covered with pads and tipped with claws. Ignis has seven fox tails, though you have difficulty focusing on them for some reason. The kitsune wears no shoes or sandals, walking on digitigrade fox feet.  From the bulge in the front of his kimono, you can guess that he has a fox cock, probably knotted.  Ignis’ staff is propped nearby, a rod of silver metal engraved with mystic glyphs.");
			menu();
			addButton(14, "Back", mainIgnisMenu);
		}
		
		public function ignisTalks():void {
			clearOutput();
			outputText("Ignis sets down his notebook. \"<i>What do you want to talk about?</i>\"");
			menu();
			addButton(0, "Him", ignisTalkHim);
			addButton(1, "Kitsune", ignisTalkKitsune);
			addButton(14, "Back", mainIgnisMenu);
		}
		
		public function ignisTalkHim():void {
			clearOutput();
			outputText("What brings a kitsune like him to He’Xin’Dao? Ignis waves his hand indifferently. \"<i>I live here.  He’Xin’Dao has a long history of soul cultivators. It's only natural for the seer’s guild to maintain a property in a place where cultivation arts are advanced, no matter how humble. The guild is all but disbanded now, scattered to the winds by the demons. So I live in the old guild house, and provide guild services to patrons when i’m not attending other projects.</i>\"\n\n");
			outputText("Other projects?  What types of projects does he work on? Ignis rolls his eyes at you. \"<i>Research mostly.  Seers combine two distinct unearthly powers, lots of potential. I do some research now and then, developing spells that interest me as a hobby. ");
			if (flags[kFLAGS.SAND_WITCHES_FRIENDLY] > 0) outputText("I also sometimes take contracts for the sand covens. It might not look the case, but I have enough corruption in me to pose as a demon, with the right kind of glamor. I can operate better outside the desert than those floozies can. ");
			outputText("And occasionally I try and pick up one night stands at bars here and there.  Before the demons i might have been considered something of a cockslut, but nowadays with sex, sex sex \"<b>everywhere</b>\"...</i>\" Ignis shakes his head and sighs. \"<i>Most \"<b>decent</b>\" folks nowadays won’t believe you want to suck them off simply for the sake of it.  The rest are demons.  I’ve drunk my share of corruption, but I like my soul where it is, thank you very much.</i>\"");
			doNext(ignisTalks);
		}
		public function ignisTalkKitsune():void {
			clearOutput();
			outputText("Ignis holds out his hand, a miniature gout of foxfire forming on his palm. The kitsune stares forlornly into the flame. \"<i>Many things have been said about my people. Lots of rumor, though recently much of it has been true.  Kitsunes are, in the most abstract sense, the holy people of the god Thaoth.  We reflect his nature, his magic and his preferred form. Thaoth is a trickster god, symbolized by the fox.  We are a people of well mannered deceivers. We are a people of the fox. ");
			outputText("We are a tribe blessed with magical talent beyond most others, with inherent powers over flame and perspective.</i>\"  Then how do his people fit into the greater scheme of things, you ask? Ignis sighs. \"<i>My people have always been somewhat isolated, our dwellings hidden deep within the woods.  They’re hardly what you would call tourist destinations, unless you are in the good graces of a respected kitsune elder.  Sometimes we wander beyond the forest, ");
			outputText("in search of adventure or merely a more serious life, so we often ply our trade as magicians. Or tailors, as vanity and an appreciation for finer things are instilled in us at a young age.</i>\"   Suddenly, Ignis clenches his palm, the foxfire disappearing in a \"<b>fwump</b>\".");
			doNext(ignisTalks);
		}
		public function ignisTalkMagic():void {
			clearOutput();
			outputText("Ignis sets down his notebook. \"<i>What do you want to talk about?</i>\"");
			outputText("Ignis sets down his notebook. \"<i>What do you want to talk about?</i>\"");
			doNext(ignisTalks);
		}
		public function ignisTalkSeer():void {
			clearOutput();
			outputText("Ignis sets down his notebook. \"<i>What do you want to talk about?</i>\"\n\n\n\n");
			doNext(ignisTalks);
		}
		
		public function sparringWithIgnis():void {
			clearOutput();
			outputText("Him, actually.  You say that you want to fight Ignis in the arena.  It could be fun.  Ignis gives you an appraising look.  \"<i>Possibly.  It probably would be fun, but we both know who saved who back at blight ridge.</i>\"  In your defense, you were ambushed by gravity magic.  <i>Gravity magic</i>  Ignis laughs,  \"<i>Well, if you think you can handle me, let's get started.</i>\"\n\n");
			outputText("After gaining the okay from the arena’s manager, you and Ignis both walk out to the center of the arena.   You take positions facing opposite each other. You ready your [weapon], Ignis raises his staff.  <b>It’s a fight!</b>");
			startCombat(new IgnisArenaSeer());
		}
		
		public function PCbeatenIgnisAtArena():void {
			outputText("\"<i>[name], you’re a pretty good at this.  Hell, you would need to be to survive my little trick at the beginning!</i>\" He holds out his hand, you shake in a gesture of sportsmanship. ");
			if (flags[kFLAGS.IGNIS_ARENA_SEER] == 2) {
				outputText("As you pull your hand away, you notice that Ignis passed you something during the handshake. It looks like...  Some sort of ornate hair pin? It’s made of silver, with an ornate eye of silver wire and lens of crystal at the tip. Ignis winks conspiratorially at you.  \"<i>That's a seer’s pin. It’s a decoration and a tool, from the old times.  Look through the lens at the tip, and you can see past most illusions and deceptive magics. It’s aura can also boost your magic and soulpower.</i>\"  ");
				flags[kFLAGS.IGNIS_ARENA_SEER]++;
			}
			outputText("Ignis gives you a tired grin. \"<i>Well, i’m going to head back to my house and rest for a while.  I’ll be back around here later if you want to do this again.</i>\"");
			cleanupAfterCombat();
		}
		
		public function PCisBeatenByIgnisAtArena():void {
			clearOutput();
			outputText("You fall back, covered in burns and barely conscious.  You barely manage to concede the fight before you black out...");
			outputText("\n\n\n...\n\n\n");
			outputText("When you come to, you’re lying in a hospital in one of the arena’s back rooms.  Looking over yourself, you realized that all your burns and other injuries have been healed.  As you stand up though, you realize that your purse is a bit lighter… Ignis probably took the liberty of paying the healers for you. Going through a quick stretch, everything seems to feel normal. In fact, everything feels great! Thanking the presiding healer, you decide to head back to your camp.");
			cleanupAfterCombat();
		}
	}
}