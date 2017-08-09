/**
 * ...
 * @author Zevos
 */
package classes.Scenes.Places.HeXinDao 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.Scenes.NPCs.NPCAwareContent;
	import classes.Scenes.Places.HeXinDao.IgnisArenaSeer;

	public class IgnisArenaSeerScene extends NPCAwareContent
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
			outputText("He gives a short wave in return, motioning for you to sit next to him.  As you approach, Ignis clears his bag off the bench, making room for you.");
			menu();
			addButton(0, "Appearance", ignisAppearance);
			addButton(3, "Sparring", sparringWithIgnis);
			addButton(4, "Leave", camp.returnToCampUseOneHour);
		}
		
		public function ignisAppearance():void {
			clearOutput();
			outputText("Ignis is a kitsune, of the more animalistic variety.  He has a fox’s head with an angular jawline, adorned by a white pelt and covered by an unkempt mane of silvery hair.  Ignis’ slitted yellow eyes have a maniacal light to them. If you didn’t know better you would believe there was flame burning within them. His lower body is concealed by his flowing grey kimono, but from the way his kimono hangs off him you can see that he has a lithe form with little muscle, and a flat chest. ");
			outputText("His hands are pawlike, covered with pads and tipped with claws. Ignis has seven fox tails, though you have difficulty focusing on them for some reason. The kitsune wears no shoes or sandals, walking on digitigrade fox feet.  From the bulge in the front of his kimono, you can guess that he has a fox cock, probably knotted.  Ignis’ staff is propped nearby, a rod of silver metal engraved with mystic glyphs.");
			menu();
			addButton(14, "Back", mainIgnisMenu);
		}
		
		public function sparringWithIgnis():void {
			clearOutput();
			outputText("Him, actually.  You say that you want to fight Ignis in the arena.  It could be fun.  Ignis gives you an appraising look.  \"<i>Possibly.  It probably would be fun, but we both know who saved who back at blight ridge.</i>\"  In your defense, you were ambushed by gravity magic.  <i>Gravity magic</i>  Ignis laughs,  \"<i>Well, if you think you can handle me, let's get started.</i>\"\n\n");
			outputText("After gaining the okay from the arena’s manager, you and Ignis both walk out to the center of the arena.   You take positions facing opposite each other. You ready your [weapon], Ignis raises his staff.  <b>It’s a fight!</b>");
			startCombat(new IgnisArenaSeer());
		}
		
		public function PCbeatenIgnisAtArena():void {
			outputText("\"<i>[Champion], you’re a pretty good at this.  Hell, you would need to be to survive my little trick at the beginning!</i>\" He holds out his hand, you shake in a gesture of sportsmanship. ");
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