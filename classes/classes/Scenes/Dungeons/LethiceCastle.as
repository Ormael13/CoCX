//Dungeon 3: Lethice's Castle (will come when all the room descriptions are finished)
package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.BaseContent;
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.Scenes.Dungeons.DungeonEngine;
	import classes.Scenes.Dungeons.LethiceCastle.*;
	
	import coc.model.GameModel;
	
	use namespace kGAMECLASS;
	
	public class LethiceCastle extends DungeonAbstractContent
	{
		public var succubusGardener:SuccubusGardenerScene = new SuccubusGardenerScene;
		public var incubusMechanic:IncubusMechanicScene = new IncubusMechanicScene;
		
		public function LethiceCastle() 
		{
		}
		
		public function enterDungeon():void {
			kGAMECLASS.inDungeon = true;
			if (flags[kFLAGS.LETHICE_CASTLE_INCUBUS_DEAL] <= 0 && flags[kFLAGS.LETHICE_CASTLE_INCUBUS_DEFEATED] <= 0) {
				kGAMECLASS.dungeonLoc = 38;
				outputText("You enter the cave...", true);
			}
			else {
				kGAMECLASS.dungeonLoc = 45;
				outputText("Fortunately, you've memorized the location of the lift, allowing you to skip the basilisk tunnel.  You enter the lift and pull the lever.  The door closes and the platform starts moving.  It takes a while but you eventually arrive at your destination.", true);
			}
			doNext(1);
		}
		
		private function exitDungeon():void {
			kGAMECLASS.inDungeon = false;
			outputText("You slip out the cave and disappear, leaving the fortress behind.", true);
			doNext(13);	
		}
		
		public function exitDungeonByLift(display:Boolean = false):void {
			if (display) {
				clearOutput()
				outputText("You enter the elevator and pull the lever.  The door closes and the platform lowers and lowers. It takes some time but when it reaches the bottom, you leave and make your way back to your camp.");
			}
			kGAMECLASS.inDungeon = false;
			doNext(13);
		}
		
		public function roomEntrance():void {
			kGAMECLASS.dungeonLoc = 38;
			outputText("<b><u>Dungeon Entrance</u></b>\n", true);
			outputText("The inside of this cave is damp and dark, but it bears signs of frequent use. The map you got from Zetaz matches the curves of this winding passage exactly. There can be no doubt that this is the place, even though his map ends a short distance into the tunnel. Either he knew it would be a linear path or was so familiar with the territory that he didn't think it was worth writing down. You can go east, deeper into the mountain towards Lethice's fortress, or leave to the west.");
			dungeons.setDungeonButtons(null, null, null, roomTunnel1);
			addButton(5, "West (Exit)", exitDungeon);
		}
		
		public function roomTunnel1():void {
			kGAMECLASS.dungeonLoc = 39;
			outputText("<b><u>Tunnel</u></b>\n", true);
			outputText("Winding back and forth, the tunnel gradually arcs west and north from here, sloping steeply upward in the latter direction. The upward sloping side must lead to Lethice's fortress, supposedly at the top of the mountain. You'll have to be careful down here. You doubt that such an entrance would be completely unguarded. As a matter of fact... you think you can see signs of worked stone to the north. You're getting close to something.");
			dungeons.setDungeonButtons(roomTunnel2, null, roomEntrance, null);
		}
		
		public function roomTunnel2():void {
			kGAMECLASS.dungeonLoc = 40;
			outputText("<b><u>Tunnel</u></b>\n", true);
			outputText("Light trickles in from the east. After all the trekking through these subterranean holes, you've got to be close to the mountain's summit. You know that down the steeply sloped passage will take you back through the basilisks' chamber if you want to leave the way you came, but a second trip through that crowded hall might be ill-advised. It'd be best to move forward into the sun.");
			dungeons.setDungeonButtons(null, roomTunnel1, null, roomKeepEdge);
		}
		
		public function roomKeepEdge():void {
			kGAMECLASS.dungeonLoc = 41;
			outputText("<b><u>The Edge of Lethice's Keep</u></b>\n", true);
			outputText("Standing on the edge of the mountain's summit, you can see Mareth for miles in all direction. It's fairly disconcerting to focus on long with the constant shifting and twisting of the wasted areas, but here and there you can pick out islands of stability in the ephemeral terrain. You blink your eyes to clear the nauseating landscape from your view and turn back to the way ahead. Lethice's fortress lies a short distance to the north, its walls tall and stout. The gates themselves hang open. Likely she didn't expect anyone to make it this far.");
			dungeons.setDungeonButtons(roomEntryway, null, roomTunnel2, null);
		}
		
		public function roomEntryway():void {
			kGAMECLASS.dungeonLoc = 42;
			outputText("<b><u>North Entryway</u></b>\n", true);
			outputText("You now stand in the archway that is the southern entrance to Lethice's headquarters. The place is built like a castle. You can't see too much from your shaded position, but the bricks that surround you are individual as big as horses. The gates themselves are crafted of wood that looks at least a century old, reinforced with bands of gleaming metal that you doubt will ever rust. A barren cliffside can be seen to the south, the demon queen's lair to the north.");
			dungeons.setDungeonButtons(roomSouthCourtyard, roomKeepEdge, null, null);
		}
		
		public function roomSouthCourtyard():void {
			kGAMECLASS.dungeonLoc = 43;
			outputText("<b><u>The Southern Courtyard</u></b>\n", true);
			outputText("Lethice's courtyard is surprisingly well-groomed for a place that's supposedly home to neverending debauchery and depravity. The paths are laid with interconnecting sandstone bricks that reflect the sun to give the place a gentle, amber glow, and lush, green grass lines the sides along with well-trimmed hedges. You could almost mistake this place for a churchyard if it wasn't for the faint sound of moans on the wind. The courtyard paths lead away east and west, while the gateway out hangs open to the south.");
			dungeons.setDungeonButtons(null, roomEntryway, roomSouthWestCourtyard, roomSouthEastCourtyard);
		}
		
		public function roomSouthEastCourtyard():void {
			kGAMECLASS.dungeonLoc = 44;
			outputText("<b><u>The Southeast Courtyard</u></b>\n", true);
			outputText("Walking along the sandstone path, you're treated to a remarkably peaceful view. Up here, above the clouds the ring the mountain, it's almost too easy to let your guard down. A small hole in the southern wall of Lethice's fortress appears to the south. Peeking through, you can see machinery and some kind of lift suspended over the cliffside. That must be how the demons can come and go safely. You can continue to walk among the bushes to the north and west. An iron door to the east bears lettering denoting it as \"recreation.\" A small placard explains that it's currently off limits due to renovations. Graffiti below complains about some contractor named Fenoxo delivering on his promised work schedule.");
			dungeons.setDungeonButtons(roomSouthEastWalk, roomGreatLift, roomSouthCourtyard, null);
		}
				
		public function roomGreatLift():void {
			kGAMECLASS.dungeonLoc = 45;
			outputText("<b><u>The Great Lift</u></b>\n", true);
			outputText("Intricate stonework supports this precarious platform as it juts from the side of Lethice's fortress, hanging over a sheer cliff that must go down for hundreds of feet. The harpies appear to have moved away from the area immediately below, whether by choice or by demonic action, though you can still spot a few of their nests in other places on the mountainside. A complicated looking machine sits on the side of the platform, attached to a cage that dangles over the edge, supported by a lowly metal cable. It must be some kind of mechanical lift - a way to come and go as one would please.");
			dungeons.setDungeonButtons(roomSouthEastCourtyard, null, null, null);
			if (flags[kFLAGS.LETHICE_CASTLE_INCUBUS_DEFEATED] <= 0 && flags[kFLAGS.LETHICE_CASTLE_INCUBUS_DEAL] != 1) addButton(3, "Incubus", incubusMechanic.approachIncubus);
			else addButton(3, "Lift", exitDungeonByLift, true);
		}
		
		public function roomSouthWestCourtyard():void {
			kGAMECLASS.dungeonLoc = 46;
			outputText("<b><u>The Southwest Courtyard</u></b>\n", true);
			outputText("Some of the nearby bushes are blooming, filling the air with their sweet scent, unlike any flowers you've encounter before. Their petals are a multitude of colors, and their scents, though laced with corruption, are as sweet and pleasant as anything you've had the pleasure of smelling. The path you're treading upon curves north and east from here along the thick, red walls. Vines seem to crowd the way to the north. There are no signs of any ramps or ladders to get to the battlements, but there is a doorway to the west marked as \"Forge Wing.\" A notice declares it closed for repairs.");
			dungeons.setDungeonButtons(roomSouthWestWalk, null, null, roomSouthCourtyard);
		}
		
		public function roomSouthWestWalk():void {
			kGAMECLASS.dungeonLoc = 47;
			outputText("<b><u>The Southwest Walk</u></b>\n", true);
			outputText("The bushes surrounding the path have given way here to a mass of tentacles, some still bedecked in the flowers that surround the air. They twist and writhe but seem content to stay in their place for now. Besides, if you hang back along the edge of the walk, you should be out of their reach. The path heads north and south... if the wall of oily-looking tendrils leaves you alone.");
			dungeons.setDungeonButtons(roomWestWalk, roomSouthWestCourtyard, null, null);
		}

		public function roomWestWalk():void {
			kGAMECLASS.dungeonLoc = 48;
			outputText("<b><u>The West Walk</u></b>\n", true);
			outputText("Pollen clings to you, released by the many flowering bushes in the area. They only grow thicker to the south, too. To the east, you can spot ");
			if (flags[kFLAGS.LETHICE_CASTLE_STATUE_DEFEATED] < 0) outputText("a massive statue with an immense hammer");
			else outputText("a mound of rubble, the scattered remains of the animated statue that you slew");
			outputText(". The warm, sandstone bricks underfoot fork in a T-intersection, leading north, east, and south. The thick castle walls prevent passage to the west.");
			dungeons.setDungeonButtons(roomNorthWestWalk, roomSouthWestWalk, null, roomCourtyardSquare);
		}

		public function roomNorthWestWalk():void {
			kGAMECLASS.dungeonLoc = 49;
			outputText("<b><u>The Northwest Walk</u></b>\n", true);
			outputText("A narrow path splits from the sandstone thoroughfare towards a pair of double doors to the west. The craftsmanship of the carpenter who made them is on full display; intricate designs of dragons engaged in sexual positions of all kinds are carved around the outer edges of the frame while more mundane, eye-pleasing patterns decorate the center panels. Above, a sign designates this area as the library. Unfortunately the doors are sealed closed. Perhaps the library is not yet written. You smirk at your own joke.");
			outputText("\n\nThe courtyard itself continues much as it has elsewhere. The bushes to the south appear more unruly than elsewhere, but to the north there appears to be nothing but pleasant walking through this botanical paradise.");
			dungeons.setDungeonButtons(roomNorthWestCourtyard, roomWestWalk, null, null);
		}
		
		public function roomNorthWestCourtyard():void {
			kGAMECLASS.dungeonLoc = 50;
			outputText("<b><u>The Northwest Courtyard</u></b>\n", true);
			outputText("The courtyard comes to an abrupt end here, hemmed in by a impressively high stone wall to the north, high enough to shame the walls in the other cardinal directions. The path is also bounded in by stonework to the west, forcing it to curve to the east and south around a bush that has been tastelessly shaped to resemble a turgid prick. The demons even went so far as to trim ivory flowers into a contiguous path along one side, very much looking like a stream of arboreal spunk.");
			dungeons.setDungeonButtons(null, roomNorthWestWalk, null, roomNorthCourtyard);
		}
		
		public function roomNorthCourtyard():void {
			kGAMECLASS.dungeonLoc = 51;
			outputText("<b><u>The Northern Courtyard</u></b>\n", true);
			outputText("You stand before what can only be the entrance to Lethice's throne room. It is unlabelled, but the immense door is unlike any you've seen in this world or the last. Constructed from some kind of pink-tinged metal and polished to a mirror sheen, this portal has had a lifetime of care poured into it. What's more, intricate locking mechanisms overlap the edges of it, each one culminating in an intricately worked seal. Fortunately, each of the seals has been left over. Security must not be much of a concern for the demon queen at this point in time. If only the door would open. For some reason, it's still sealed closed. You can still move east and west through the courtyard, if you like.");
			dungeons.setDungeonButtons(null, null, roomNorthWestCourtyard, roomNorthEastCourtyard);
		}
		
		public function roomNorthEastCourtyard():void {
			kGAMECLASS.dungeonLoc = 52;
			outputText("<b><u>The Northeast Courtyard</u></b>\n", true);
			outputText("This particular corner of the courtyard feels remarkably cramped, even a little claustrophobic. To the north, a stone wall rises, dwarfing the smaller one to the east, and to make matters worse, the hedges to the southwest are high and square, virtually a wall in their own right. The only avenues of travel available are to the south or west, following the red sandstone bricks as they bend around the corner.");
			dungeons.setDungeonButtons(null, roomNorthEastWalk, roomNorthCourtyard, null);
		}
		
		public function roomNorthEastWalk():void {
			kGAMECLASS.dungeonLoc = 53;
			outputText("<b><u>The Northeast Walk</u></b>\n", true);
			outputText("The air is pleasant and free here. Not even the corrupt nature of this place can stop you from enjoying this moment in the demon queen's garden. Still, there is an aura of lingering danger here. The flowers smell pleasant but somehow off, and every now and again the breezes carry the sounds of whorish moans. An entryway in the east wall leads towards the barracks and mess, identified by a simple sign to the left of the imposing iron door frame. Fortunately, the door is barred and sealed. It seems you've come at a time when Lethice's fortress is near empy. How fortunate for you.");
			dungeons.setDungeonButtons(roomNorthEastCourtyard, roomEastWalk, null, null);
		}
		
		public function roomEastWalk():void {
			kGAMECLASS.dungeonLoc = 54;
			outputText("<b><u>The East Walk</u></b>\n", true);
			outputText("The smooth, almost flawlessly laid stones split into a T-intersection here, heading north, south, and west. The bushes that hem in the paths are likewise split, though they have been maintained with the same sense of care you've seen elsewhere in the garden. One particularly interesting shrub has been trimmed into the shape of a large bust, complete with erect nipples. You shake your head and glance west, where you can spot {a massive statue with an immense hammer/a mound of rubble, the scattered remains of the animated statue that you slew}");
			dungeons.setDungeonButtons(roomNorthEastWalk, roomSouthEastWalk, roomCourtyardSquare, null);
		}
		
		public function roomSouthEastWalk():void {
			kGAMECLASS.dungeonLoc = 55;
			outputText("<b><u>The Southeast Walk</u></b>\n", true);
			outputText("Swarms of butterflies congregate on the flowering bushes here. At first, the sight seems beautiful, almost pristine. Then, you spot the endemic corruption that Lethice has spread through the lands. They aren't just swarms of butterflies - they're swarms of mating butterflies, crawling all over each other in a swarm of sweet-smelling pollen and fluttering wings. You had best move on. The path leads north and south.");
			dungeons.setDungeonButtons(roomEastWalk, roomSouthEastCourtyard, null, null);
		}
		
		public function roomCourtyardSquare():void {
			kGAMECLASS.dungeonLoc = 56;
			outputText("<b><u>Courtyard Square</u></b>\n", true);
			if (flags[kFLAGS.LETHICE_CASTLE_STATUE_DEFEATED] > 0) outputText("Two disembodied, marble feet and a field of rubble are all that remains of the once proud statue that stood in the center of the courtyard. You dealt with the animated monstrosity but can't help but feel a little shame at the destruction you've so openly wrought. Many of the bushes are torn in half by two ton slabs, and the path is scarred in a dozen places by chips and smashed divots. You can go east and west from here, if you move carefully around the more jagged pieces of stone.");
			else outputText("A circle of polished stone wraps around a colossus here in the center of the courtyard, ringed by cushioned benches that would be a delight to sit on were they not stained with bodily fluids of all colors and sexes. You didn't think pink cum was possible, but the demons' endless sexual creativity doesn't seem to be bound by such notions. You can leave east and west from here.");
			dungeons.setDungeonButtons(null, null, roomWestWalk, roomEastWalk);
		}
		

		
	}

}