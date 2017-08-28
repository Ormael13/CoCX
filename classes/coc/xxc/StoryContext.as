/**
 * Coded by aimozg on 28.08.2017.
 */
package coc.xxc {
import classes.CoC;

import coc.xlogic.ExecContext;

public class StoryContext extends ExecContext{
	public var game:CoC;
	public function StoryContext(game:CoC) {
		super([game]);
		this.game = game;
	}
}
}
