Contributing to CoC
==============

If you'd like to work on CoC, here are some things to keep in mind.

1. **Work on CoC happens slowly.** CoC is considered largely complete. The CoC leadership's primary focus is on TiTS, and CoC is a weekend project for them at this point. Do not expect quick turnaround.
2. **One change per pull request.** If you try to submit a new monster, support for multiple vaginas, a bunch of grammar fixes, and a redesign of the pregnancy system all in one pull request, we will probably close your pull request and tell you to submit four separate ones (and probably not that politely, either). When you mix changes together like that, it's impossible to tell which of your edits are related to which features. That means we can't see what you're doing, which means we can't see if you're doing things correctly.
3. **Be cautious when refactoring.** CoC is an old codebase with lots of crap in it that's begging to be redesigned. But there are several reasons you should be very cautious:
 * **CoC is complicated.** A lot of factors are involved in something as simple as deciding how much your lust increases each hour; if you're not careful, you'll miss something.
 * **It's really, really easy to write bugs in CoC.** ActionScript is not a strict language, CoC does not have comprehensive unit tests, and as previously stated, CoC is complicated. Those factors make CoC a minefield. Did you test your new scene with a bat-winged, scaled, pregnant, three-cocked hermaphrodite centaur with two identical cock socks, the beautiful sword, a hairless corrupted Amily, and a minotaur cum addiction? Because somebody probably has a character like that, and their bug reports will make you weep.
 * **Some core CoC developers are amateur programmers**. They have trouble understanding fancy tricks. Some of the things they consider to be "fancy tricks" may seem pretty simple to you.
 * **Most CoC developers are putting most of their attention elsewhere** (see point 1). If the codebase moves too far ahead too fast, they will have trouble working on the game.
4. **The fact that there's shitty code in CoC doesn't mean you get to write shitty code, too.** The first step in making CoC better is making sure it doesn't get any worse. Don't copy and paste when you should be using functions, don't fill your code with magic numbers, don't expand systems we're trying to get rid of, and don't write code that's spaghetti-er than it has to be. Use common sense.
5. **Communicate.** If you want to do something big, talk it over with us first. This will be a slow process (see point 1), but it will save you from wasting your time.

Good luck!
