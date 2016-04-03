//Copyright (c) 2010, Charles Strahan
//<http://www.charlesstrahan.com/>  
//All rights reserved.
//	
//	Original Showdown Copyright (c) 2007, John Fraser  
//<http://www.attacklab.net/>  
//All rights reserved.
//	
//	Original Markdown copyright (c) 2004, John Gruber  
//<http://daringfireball.net/>  
//All rights reserved.
//	
//	Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are
//met:
//
//* Redistributions of source code must retain the above copyright notice,
//this list of conditions and the following disclaimer.
//	
//	* Redistributions in binary form must reproduce the above copyright
//notice, this list of conditions and the following disclaimer in the
//documentation and/or other materials provided with the distribution.
//	
//	* Neither the name "Markdown" nor the names of its contributors may
//be used to endorse or promote products derived from this software
//without specific prior written permission.
//	
//	This software is provided by the copyright holders and contributors "as
//is" and any express or implied warranties, including, but not limited
//to, the implied warranties of merchantability and fitness for a
//particular purpose are disclaimed. In no event shall the copyright owner
//or contributors be liable for any direct, indirect, incidental, special,
//exemplary, or consequential damages (including, but not limited to,
//	procurement of substitute goods or services; loss of use, data, or
//	profits; or business interruption) however caused and on any theory of
//liability, whether in contract, strict liability, or tort (including
//	negligence or otherwise) arising in any way out of the use of this
//software, even if advised of the possibility of such damage.

//
// Showdown.as -- An ActionScript port of showdown.js
//
// Copyright (c) 2010 Charles Strahan.
//
// Original Showdown Copyright (c) 2007 John Fraser.
//   <http://attacklab.net/showdown/>
//
// Original Markdown Copyright (c) 2004-2005 John Gruber
//   <http://daringfireball.net/projects/markdown/>
//
// Redistributable under a BSD-style open source license.
// See license.txt for more information.
//
// Usage:
//
//   var text = "Markdown *rocks*.";
//   var html = Showdown.makeHtml(text);
//

package showdown {

	public class Showdown
	{
		// Global hashes, used by various utility routines
		private static var g_urls:Array;
		private static var g_titles:Array;
		private static var g_html_blocks:Array;
		
		// Used to track when we're inside an ordered or unordered list
		// (see _ProcessListItems() for details):
		private static var g_list_level:Number = 0;
		
		public static function makeHtml(text:String):String
		{
			// Clear the global hashes. If we don't clear these, you get conflicts
			// from other articles when generating a page which contains more than
			// one article (e.g. an index page that shows the N most recent
			// articles):
			g_urls = [];
			g_titles = [];
			g_html_blocks = [];
			
			// attacklab: Replace ~ with ~T
			// This lets us use tilde as an escape char to avoid md5 hashes
			// The choice of character is arbitray; anything that isn't
			// magic in Markdown will work.
			text = text.replace(/~/g,"~T");
			
			// attacklab: Replace $ with ~D
			// RegExp interprets $ as a special character
			// when it's in a replacement string
			text = text.replace(/\$/g,"~D");
			
			// Standardize line endings
			text = text.replace(/\r\n/g,"\n"); // DOS to Unix
			text = text.replace(/\r/g,"\n"); // Mac to Unix
			
			// Make sure text begins and ends with a couple of newlines:
			text = "\n\n" + text + "\n\n";
			
			// Convert all tabs to spaces.
			text = _Detab(text);
			
			// Strip any lines consisting only of spaces and tabs.
			// This makes subsequent regexen easier to write, because we can
			// match consecutive blank lines with /\n+/ instead of something
			// contorted like /[ \t]*\n+/ .
			text = text.replace(/^[ \t]+$/mg,"");
			
			// Turn block-level HTML blocks into hash entries
			text = _HashHTMLBlocks(text);
			
			// Strip link definitions, store in hashes.
			text = _StripLinkDefinitions(text);
			
			text = _RunBlockGamut(text);
			
			text = _UnescapeSpecialChars(text);			
			
			// attacklab: Restore dollar signs
			text = text.replace(/~D/g,"$$");
			
			// attacklab: Restore tildes
			text = text.replace(/~T/g,"~");

			// unfortunately, because flash is on crack, the "htmlText" window still inserts breaks at "\n" 
			// characters AS WELL AS <p> tags. Therefore, we remove all the newline tags after parsing to HTML, and before 
			// trying to display the contents.
			// FLASH: YOU CRAZY
			text = text.replace(/\n/g, "");

			// Finally, add a additional newline after each closing P tag, because flash only
			// outputs one newline per <p></p> tag, apparently flash again feels the need to be a special snowflake
			// text = text.replace(/<\/p>/gi,"</p>\n");
			// aaaannnnd now it's properly producing two \n's between paragraphs. WTF, Flash?


			return text;
		}
		
		
		private static function _StripLinkDefinitions(text:String):String {
			//
			// Strips link definitions from text, stores the URLs and titles in
			// hash references.
			//
			
			// Link defs are in the form: ^[id]: url "optional title"
			
			/*
			var text = text.replace(/
			^[ ]{0,3}\[(.+)\]:  // id = $1  attacklab: g_tab_width - 1
			[ \t]*
			\n?				// maybe *one* newline
			[ \t]*
			<?(\S+?)>?			// url = $2
			[ \t]*
			\n?				// maybe one newline
			[ \t]*
			(?:
			(\n*)				// any lines skipped = $3 attacklab: lookbehind removed
			["(]
			(.+?)				// title = $4
			[")]
			[ \t]*
			)?					// title is optional
			(?:\n+|$)
			/gm,
			function(){...});
			*/
			text = text.replace(/^[ ]{0,3}\[(.+)\]:[ \t]*\n?[ \t]*<?(\S+?)>?[ \t]*\n?[ \t]*(?:(\n*)["(](.+?)[")][ \t]*)?(?:\n+|\Z)/gm,
				function (wholeMatch:String,m1:*,m2:*,m3:*,m4:*,...args):String {
					m1 = m1.toLowerCase();
					g_urls[m1] = _EncodeAmpsAndAngles(m2);  // Link IDs are case-insensitive
					if (m3) {
						// Oops, found blank lines, so it's not a title.
						// Put back the parenthetical statement we stole.
						return m3+m4;
					} else if (m4) {
						g_titles[m1] = m4.replace(/"/g,"&quot;");
					}
					
					// Completely remove the definition from the text
					return "";
				}
			);
			
			return text;
		}
		
		
		private static function _HashHTMLBlocks(text:String):String {
			// attacklab: Double up blank lines to reduce lookaround
			text = text.replace(/\n/g,"\n\n");
			
			// Hashify HTML blocks:
			// We only want to do this for block-level HTML tags, such as headers,
			// lists, and tables. That's because we still want to wrap <p>s around
			// "paragraphs" that are wrapped in non-block-level tags, such as anchors,
			// phrase emphasis, and spans. The list of tags we're looking for is
			// hard-coded:
			//noinspection JSUnusedLocalSymbols
			var block_tags_a:String = "p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del";
			//noinspection JSUnusedLocalSymbols
			var block_tags_b:String = "p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math";
			
			// First, look for nested blocks, e.g.:
			//   <div>
			//     <div>
			//     tags for inner block must be indented.
			//     </div>
			//   </div>
			//
			// The outermost tags must start at the left margin for this to match, and
			// the inner nested divs must be indented.
			// We need to do this before the next, more liberal match, because the next
			// match will start at the first `<div>` and stop at the first `</div>`.
			
			// attacklab: This regex can be expensive when it fails.
			/*
			var text = text.replace(/
			(						// save in $1
			^					// start of line  (with /m)
			<($block_tags_a)	// start tag = $2
			\b					// word break
			// attacklab: hack around khtml/pcre bug...
			[^\r]*?\n			// any number of lines, minimally matching
			</\2>				// the matching end tag
			[ \t]*				// trailing spaces/tabs
			(?=\n+)				// followed by a newline
			)						// attacklab: there are sentinel newlines at end of document
			/gm,function(){...}};
			*/
			
			text = text.replace(/^(<(p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math|ins|del)\b[^\r]*?\n<\/\2>[ \t]*(?=\n+))/gm,hashElement);
			
			//
			// Now match more liberally, simply from `\n<tag>` to `</tag>\n`
			//
			
			/*
			var text = text.replace(/
			(						// save in $1
			^					// start of line  (with /m)
			<($block_tags_b)	// start tag = $2
			\b					// word break
			// attacklab: hack around khtml/pcre bug...
			[^\r]*?				// any number of lines, minimally matching
			.*</\2>				// the matching end tag
			[ \t]*				// trailing spaces/tabs
			(?=\n+)				// followed by a newline
			)						// attacklab: there are sentinel newlines at end of document
			/gm,function(){...}};
			*/
			text = text.replace(/^(<(p|div|h[1-6]|blockquote|pre|table|dl|ol|ul|script|noscript|form|fieldset|iframe|math)\b[^\r]*?.*<\/\2>[ \t]*(?=\n+)\n)/gm,hashElement);
			
			// Special case just for <hr />. It was easier to make a special case than
			// to make the other regex more complicated.  
			
			/*
			text = text.replace(/
			(						// save in $1
			\n\n				// Starting after a blank line
			[ ]{0,3}
			(<(hr)				// start tag = $2
			\b					// word break
			([^<>])*?			// 
			\/?>)				// the matching end tag
			[ \t]*
			(?=\n{2,})			// followed by a blank line
			)
			/g,hashElement);
			*/
			text = text.replace(/(\n[ ]{0,3}(<(hr)\b([^<>])*?\/?>)[ \t]*(?=\n{2,}))/g,hashElement);
			
			// Special case for standalone HTML comments:
			
			/*
			text = text.replace(/
			(						// save in $1
			\n\n				// Starting after a blank line
			[ ]{0,3}			// attacklab: g_tab_width - 1
			<!
			(--[^\r]*?--\s*)+
			>
			[ \t]*
			(?=\n{2,})			// followed by a blank line
			)
			/g,hashElement);
			*/
			text = text.replace(/(\n\n[ ]{0,3}<!(--[^\r]*?--\s*)+>[ \t]*(?=\n{2,}))/g,hashElement);
			
			// PHP and ASP-style processor instructions (<?...?> and <%...%>)
			
			/*
			text = text.replace(/
			(?:
			\n\n				// Starting after a blank line
			)
			(						// save in $1
			[ ]{0,3}			// attacklab: g_tab_width - 1
			(?:
			<([?%])			// $2
			[^\r]*?
			\2>
			)
			[ \t]*
			(?=\n{2,})			// followed by a blank line
			)
			/g,hashElement);
			*/
			text = text.replace(/(?:\n\n)([ ]{0,3}(?:<([?%])[^\r]*?\2>)[ \t]*(?=\n{2,}))/g,hashElement);
			
			// attacklab: Undo double lines (see comment at top of this function)
			text = text.replace(/\n\n/g,"\n");
			return text;
		}

		//noinspection JSUnusedLocalSymbols
		private static function hashElement(wholeMatch:String,m1:*,m2:*,m3:*,m4:*,...args):String {
			var blockText:String = m1;
			
			// Undo double lines
			blockText = blockText.replace(/\n\n/g,"\n");
			blockText = blockText.replace(/^\n/,"");
			
			// strip trailing blank lines
			blockText = blockText.replace(/\n+$/g,"");
			
			// Replace the element text with a marker ("~KxK" where x is its key)
			blockText = "\n\n~K" + (g_html_blocks.push(blockText)-1) + "K\n\n";
			
			return blockText;
		}
		
		private static function _RunBlockGamut(text:String):String {
			//
			// These are all the transformations that form block-level
			// tags like paragraphs, headers, and list items.
			//
			text = _DoHeaders(text);
			
			// Do Horizontal Rules:
			var key:String = hashBlock("<hr />");
			text = text.replace(/^[ ]{0,2}([ ]?\*[ ]?){3,}[ \t]*$/gm,key);
			text = text.replace(/^[ ]{0,2}([ ]?\-[ ]?){3,}[ \t]*$/gm,key);
			text = text.replace(/^[ ]{0,2}([ ]?\_[ ]?){3,}[ \t]*$/gm,key);
			
			text = _DoTables(text);
			text = _DoLists(text);
			text = _DoCodeBlocks(text);
			text = _DoBlockQuotes(text);
			
			// We already ran _HashHTMLBlocks() before, in Markdown(), but that
			// was to escape raw HTML in the original Markdown source. This time,
			// we're escaping the markup we've just created, so that we don't wrap
			// <p> tags around block-level tags.
			text = _HashHTMLBlocks(text);
			text = _FormParagraphs(text);
			
			return text;
		}
		
		
		private static function _RunSpanGamut(text:String):String {
			//
			// These are all the transformations that occur *within* block-level
			// tags like paragraphs, headers, and list items.
			//
			
			text = _DoCodeSpans(text);
			text = _EscapeSpecialCharsWithinTagAttributes(text);
			text = _EncodeBackslashEscapes(text);
			
			// Process anchor and image tags. Images must come first,
			// because ![foo][f] looks like an anchor.
			text = _DoImages(text);
			text = _DoAnchors(text);
			
			// Make links out of things like `<http://example.com/>`
			// Must come after _DoAnchors(), because you can use < and >
			// delimiters in inline links like [this](<url>).
			text = _DoAutoLinks(text);
			text = _EncodeAmpsAndAngles(text);
			text = _DoItalicsAndBold(text);
			
			// Do hard breaks:
			text = text.replace(/  +\n/g," <br />\n");
			
			return text;
		}
		
		private static function _EscapeSpecialCharsWithinTagAttributes(text:String):String {
			//
			// Within tags -- meaning between < and > -- encode [\ ` * _] so they
			// don't conflict with their use in Markdown for code, italics and strong.
			//
			
			// Build a regex to find HTML tags and comments.  See Friedl's 
			// "Mastering Regular Expressions", 2nd Ed., pp. 200-201.
			var regex:RegExp = /(<[a-z\/!$]("[^"]*"|'[^']*'|[^'">])*>|<!(--.*?--\s*)+>)/gi;
			
			text = text.replace(regex, function(wholeMatch:String,...args):String {
				var tag:String = wholeMatch.replace(/(.)<\/?code>(?=.)/g,"$1`");
				tag = escapeCharacters(tag,"\\`*_");
				return tag;
			});
			
			return text;
		}
		
		private static function _DoAnchors(text:String):String {
			//
			// Turn Markdown link shortcuts into XHTML <a> tags.
			//
			//
			// First, handle reference-style links: [link text] [id]
			//
			
			/*
			text = text.replace(/
			(							// wrap whole match in $1
			\[
			(
			(?:
			\[[^\]]*\]		// allow brackets nested one level
			|
			[^\[]			// or anything else
			)*
			)
			\]
			
			[ ]?					// one optional space
			(?:\n[ ]*)?				// one optional newline followed by spaces
			
			\[
			(.*?)					// id = $3
			\]
			)()()()()					// pad remaining backreferences
			/g,_DoAnchors_callback);
			*/
			text = text.replace(/(\[((?:\[[^\]]*\]|[^\[\]])*)\][ ]?(?:\n[ ]*)?\[(.*?)\])()()()()/g,writeAnchorTag);
			
			//
			// Next, inline-style links: [link text](url "optional title")
			//
			
			/*
			text = text.replace(/
			(						// wrap whole match in $1
			\[
			(
			(?:
			\[[^\]]*\]	// allow brackets nested one level
			|
			[^\[\]]			// or anything else
			)
			)
			\]
			\(						// literal paren
			[ \t]*
			()						// no id, so leave $3 empty
			<?(.*?)>?				// href = $4
			[ \t]*
			(						// $5
			(['"])				// quote char = $6
			(.*?)				// Title = $7
			\6					// matching quote
			[ \t]*				// ignore any spaces/tabs between closing quote and )
			)?						// title is optional
			\)
			)
			/g,writeAnchorTag);
			*/
			text = text.replace(/(\[((?:\[[^\]]*\]|[^\[\]])*)\]\([ \t]*()<?(.*?)>?[ \t]*((['"])(.*?)\6[ \t]*)?\))/g,writeAnchorTag);
			
			//
			// Last, handle reference-style shortcuts: [link text]
			// These must come last in case you've also got [link test][1]
			// or [link test](/foo)
			//
			
			/*
			text = text.replace(/
			(		 					// wrap whole match in $1
			\[
			([^\[\]]+)				// link text = $2; can't contain '[' or ']'
			\]
			)()()()()()					// pad rest of backreferences
			/g, writeAnchorTag);
			*/
			text = text.replace(/(\[([^\[\]]+)\])()()()()()/g, writeAnchorTag);
			
			return text;
		}

		//noinspection JSUnusedLocalSymbols
		private static function writeAnchorTag(wholeMatch:String,m1:*,m2:*,m3:*,m4:*,m5:*,m6:*,m7:*,m8:*,m9:*,...args):String {
			if (m7 == undefined) m7 = "";
			//noinspection UnnecessaryLocalVariableJS
			var whole_match:String = m1;
			//noinspection UnnecessaryLocalVariableJS
			var link_text:String   = m2;
			var link_id:String	 = m3.toLowerCase();
			var url:String		= m4;
			var title:String	= m7;
			
			if (url == "") {
				if (link_id == "") {
					// lower-case and turn embedded newlines into spaces
					link_id = link_text.toLowerCase().replace(/ ?\n/g," ");
				}
				url = "#"+link_id;
				
				if (g_urls[link_id] != undefined) {
					url = g_urls[link_id];
					if (g_titles[link_id] != undefined) {
						title = g_titles[link_id];
					}
				}
				else {
					if (whole_match.search(/\(\s*\)$/m)>-1) {
						// Special case for explicit empty url
						url = "";
					} else {
						return whole_match;
					}
				}
			}	
			
			url = escapeCharacters(url,"*_");
			var result:String = "<a href=\"" + url + "\"";
			
			if (title != "") {
				title = title.replace(/"/g,"&quot;");
				title = escapeCharacters(title,"*_");
				result +=  " title=\"" + title + "\"";
			}
			
			result += ">" + link_text + "</a>";
			
			return result;
		}
		
		
		private static function _DoImages(text:String):String {
			//
			// Turn Markdown image shortcuts into <img> tags.
			//
			
			//
			// First, handle reference-style labeled images: ![alt text][id]
			//
			
			/*
			text = text.replace(/
			(						// wrap whole match in $1
			!\[
			(.*?)				// alt text = $2
			\]
			
			[ ]?				// one optional space
			(?:\n[ ]*)?			// one optional newline followed by spaces
			
			\[
			(.*?)				// id = $3
			\]
			)()()()()				// pad rest of backreferences
			/g,writeImageTag);
			*/
			text = text.replace(/(!\[(.*?)\][ ]?(?:\n[ ]*)?\[(.*?)\])()()()()/g,writeImageTag);
			
			//
			// Next, handle inline images:  ![alt text](url "optional title")
			// Don't forget: encode * and _
			
			/*
			text = text.replace(/
			(						// wrap whole match in $1
			!\[
			(.*?)				// alt text = $2
			\]
			\s?					// One optional whitespace character
			\(					// literal paren
			[ \t]*
			()					// no id, so leave $3 empty
			<?(\S+?)>?			// src url = $4
			[ \t]*
			(					// $5
			(['"])			// quote char = $6
			(.*?)			// title = $7
			\6				// matching quote
			[ \t]*
			)?					// title is optional
			\)
			)
			/g,writeImageTag);
			*/
			text = text.replace(/(!\[(.*?)\]\s?\([ \t]*()<?(\S+?)>?[ \t]*((['"])(.*?)\6[ \t]*)?\))/g,writeImageTag);
			
			return text;
		}

		//noinspection JSUnusedLocalSymbols
		private static function writeImageTag(wholeMatch:String,m1:*,m2:*,m3:*,m4:*,m5:*,m6:*,m7:*,m8:*,m9:*):String {
			//noinspection UnnecessaryLocalVariableJS
			var whole_match:String = m1;
			var alt_text:String   = m2;
			var link_id:String	 = m3.toLowerCase();
			var url:String		= m4;
			var title:String	= m7;
			
			if (!title) title = "";
			
			if (url == "") {
				if (link_id == "") {
					// lower-case and turn embedded newlines into spaces
					link_id = alt_text.toLowerCase().replace(/ ?\n/g," ");
				}
				url = "#"+link_id;
				
				if (g_urls[link_id] != undefined) {
					url = g_urls[link_id];
					if (g_titles[link_id] != undefined) {
						title = g_titles[link_id];
					}
				}
				else {
					return whole_match;
				}
			}	
			
			alt_text = alt_text.replace(/"/g,"&quot;");
			url = escapeCharacters(url,"*_");
			var result:String = "<img src=\"" + url + "\" alt=\"" + alt_text + "\"";
			
			// attacklab: Markdown.pl adds empty title attributes to images.
			// Replicate this bug.
			
			//if (title != "") {
			title = title.replace(/"/g,"&quot;");
			title = escapeCharacters(title,"*_");
			result +=  " title=\"" + title + "\"";
			//}
			
			result += " />";
			
			return result;
		}
		
		
		private static function _DoHeaders(text:String):String {
			
			// Setext-style headers:
			//	Header 1
			//	========
			//  
			//	Header 2
			//	--------
			//
			text = text.replace(/^(.+)[ \t]*\n=+[ \t]*\n+/gm,
				function(wholeMatch:String,m1:String,...args):String{return hashBlock("<h1>" + _RunSpanGamut(m1) + "</h1>");});
			
			text = text.replace(/^(.+)[ \t]*\n-+[ \t]*\n+/gm,
				function(matchFound:String,m1:String,...args):String{return hashBlock("<h2>" + _RunSpanGamut(m1) + "</h2>");});
			
			// atx-style headers:
			//  # Header 1
			//  ## Header 2
			//  ## Header 2 with closing hashes ##
			//  ...
			//  ###### Header 6
			//
			
			/*
			text = text.replace(/
			^(\#{1,6})				// $1 = string of #'s
			[ \t]*
			(.+?)					// $2 = Header text
			[ \t]*
			\#*						// optional closing #'s (not counted)
			\n+
			/gm, function() {...});
			*/
			
			text = text.replace(/^(\#{1,6})[ \t]*(.+?)[ \t]*\#*\n+/gm,
				function(wholeMatch:String,m1:String,m2:String,...args):String {
					var h_level:int = m1.length;
					return hashBlock("<h" + h_level + ">" + _RunSpanGamut(m2) + "</h" + h_level + ">");
				});
			
			return text;
		}
		
		private static function _DoLists(text:String):String {
			//
			// Form HTML ordered (numbered) and unordered (bulleted) lists.
			//
			
			// attacklab: add sentinel to hack around khtml/safari bug:
			// http://bugs.webkit.org/show_bug.cgi?id=11231
			text += "~0";
			
			// Re-usable pattern to match any entirel ul or ol list:
			
			/*
			var whole_list = /
			(									// $1 = whole list
			(								// $2
			[ ]{0,3}					// attacklab: g_tab_width - 1
			([*+-]|\d+[.])				// $3 = first list item marker
			[ \t]+
			)
			[^\r]+?
			(								// $4
			~0							// sentinel for workaround; should be $
			|
			\n{2,}
			(?=\S)
			(?!							// Negative lookahead for another list item marker
			[ \t]*
			(?:[*+-]|\d+[.])[ \t]+
			)
			)
			)/g
			*/
			var whole_list:RegExp = /^(([ ]{0,3}([*+-]|\d+[.])[ \t]+)[^\r]+?(~0|\n{2,}(?=\S)(?![ \t]*(?:[*+-]|\d+[.])[ \t]+)))/gm;
			
			if (g_list_level) {
				text = text.replace(whole_list,function(wholeMatch:String,m1:String,m2:String,...args):String {
					var list:String = m1;
					var list_type:String = (m2.search(/[*+-]/g)>-1) ? "ul" : "ol";
					
					// Turn double returns into triple returns, so that we can make a
					// paragraph for the last item in a list, if necessary:
					list = list.replace(/\n{2,}/g,"\n\n\n");
					var result:String = _ProcessListItems(list);
					
					// Trim any trailing whitespace, to put the closing `</$list_type>`
					// up on the preceding line, to get it past the current stupid
					// HTML block parser. This is a hack to work around the terrible
					// hack that is the HTML block parser.
					result = result.replace(/\s+$/,"");
					result = "<"+list_type+">" + result + "</"+list_type+">\n";
					return result;
				});
			} else {
				whole_list = /(\n\n|^\n?)(([ ]{0,3}([*+-]|\d+[.])[ \t]+)[^\r]+?(~0|\n{2,}(?=\S)(?![ \t]*(?:[*+-]|\d+[.])[ \t]+)))/g;
				text = text.replace(whole_list,function(wholeMatch:String,m1:String,m2:String,m3:String,...args):String {
					//noinspection UnnecessaryLocalVariableJS
					var runup:String = m1;
					var list:String = m2;
					
					var list_type:String = (m3.search(/[*+-]/g)>-1) ? "ul" : "ol";
					// Turn double returns into triple returns, so that we can make a
					// paragraph for the last item in a list, if necessary:
					list = list.replace(/\n{2,}/g,"\n\n\n");
					var result:String = _ProcessListItems(list);
					result = runup + "<"+list_type+">\n" + result + "</"+list_type+">\n";	
					return result;
				});
			}
			
			// attacklab: strip sentinel
			text = text.replace(/~0/,"");
			
			return text;
		}
		
		private static function _DoTables(text:String):String {
			text = text.replace(/(?:\|(?:[^\|\r\n]+\|)+\n)+/gm,
				function(wholeMatch:String,...args):String {
					return "<table>" + _DoTableRows(wholeMatch) + "</table>";
				});
			return text
		}
		
		private static function _DoTableRows(text:String):String {
			text = text.replace(/\|((?:[^\|\r\n]+\|)+)\n/gm,
				function(wholeMatch:String, g1:String,...args):String {
					return "<tr>" + _DoTableCells(g1) + "</tr>";
				});
			return text;
		}
		
		private static function _DoTableCells(text:String):String {
			text = text.replace(/([^\|\r\n]+)\|/gm,
				function(wholeMatch:String, g1:String,...args):String {
					return "<td>" + _RunSpanGamut(g1) + "</td>";
				});
			return text;
		}
		
		private static function _ProcessListItems(list_str:String):String {
			//
			//  Process the contents of a single ordered or unordered list, splitting it
			//  into individual list items.
			//
			// The $g_list_level global keeps track of when we're inside a list.
			// Each time we enter a list, we increment it; when we leave a list,
			// we decrement. If it's zero, we're not in a list anymore.
			//
			// We do this because when we're not inside a list, we want to treat
			// something like this:
			//
			//    I recommend upgrading to version
			//    8. Oops, now this line is treated
			//    as a sub-list.
			//
			// As a single paragraph, despite the fact that the second line starts
			// with a digit-period-space sequence.
			//
			// Whereas when we're inside a list (or sub-list), that line will be
			// treated as the start of a sub-list. What a kludge, huh? This is
			// an aspect of Markdown's syntax that's hard to parse perfectly
			// without resorting to mind-reading. Perhaps the solution is to
			// change the syntax rules such that sub-lists must start with a
			// starting cardinal number; e.g. "1." or "a.".
			
			g_list_level++;
			
			// trim trailing blank lines:
			list_str = list_str.replace(/\n{2,}$/,"\n");
			
			// attacklab: add sentinel to emulate \z
			list_str += "~0";
			
			/*
			list_str = list_str.replace(/
			(\n)?							// leading line = $1
			(^[ \t]*)						// leading whitespace = $2
			([*+-]|\d+[.]) [ \t]+			// list marker = $3
			([^\r]+?						// list item text   = $4
			(\n{1,2}))
			(?= \n* (~0 | \2 ([*+-]|\d+[.]) [ \t]+))
			/gm, function(){...});
			*/
			list_str = list_str.replace(/(\n)?(^[ \t]*)([*+-]|\d+[.])[ \t]+([^\r]+?(\n{1,2}))(?=\n*(~0|\2([*+-]|\d+[.])[ \t]+))/gm,
				function(wholeMatch:String,m1:String,m2:String,m3:String,m4:String,...args):String{
					var item:String = m4;
					//noinspection UnnecessaryLocalVariableJS
					var leading_line:String = m1;
					//noinspection JSUnusedLocalSymbols
					var leading_space:String = m2;
					
					if (leading_line || (item.search(/\n{2,}/)>-1)) {
						item = _RunBlockGamut(_Outdent(item));
					}
					else {
						// Recursion for sub-lists:
						item = _DoLists(_Outdent(item));
						item = item.replace(/\n$/,""); // chomp(item)
						item = _RunSpanGamut(item);
					}
					
					return  "<li>" + item + "</li>\n";
				}
			);
			
			// attacklab: strip sentinel
			list_str = list_str.replace(/~0/g,"");
			
			g_list_level--;
			return list_str;
		}
		
		
		private static function _DoCodeBlocks(text:String):String {
			//
			//  Process Markdown `<pre><code>` blocks.
			//  
			
			/*
			text = text.replace(text,
			/(?:\n\n|^)
			(								// $1 = the code block -- one or more lines, starting with a space/tab
			(?:
			(?:[ ]{4}|\t)			// Lines must start with a tab or a tab-width of spaces - attacklab: g_tab_width
			.*\n+
			)+
			)
			(\n*[ ]{0,3}[^ \t\n]|(?=~0))	// attacklab: g_tab_width
			/g,function(){...});
			*/
			
			// attacklab: sentinel workarounds for lack of \A and \Z, safari\khtml bug
			text += "~0";
			
			text = text.replace(/(?:\n\n|^)((?:(?:[ ]{4}|\t).*\n+)+)(\n*[ ]{0,3}[^ \t\n]|(?=~0))/g,
				function(wholeMatch:String,m1:String,m2:String,...args):String {
					var codeblock:String = m1;
					//noinspection UnnecessaryLocalVariableJS
					var nextChar:String = m2;
					
					codeblock = _EncodeCode( _Outdent(codeblock));
					codeblock = _Detab(codeblock);
					codeblock = codeblock.replace(/^\n+/g,""); // trim leading newlines
					codeblock = codeblock.replace(/\n+$/g,""); // trim trailing whitespace
					
					// disabling codeblocks, because they're not needed in CoC.
					codeblock = "<p>" + codeblock + "\n</p>";
					// codeblock = "<pre><code>" + codeblock + "\n</code></pre>";
					
					return hashBlock(codeblock) + nextChar;
				}
			);
			
			// attacklab: strip sentinel
			text = text.replace(/~0/,"");
			
			return text;
		}

		//noinspection JSUnusedLocalSymbols
		private static function hashBlock(text:String,...args):String {
			text = text.replace(/(^\n+|\n+$)/g,"");
			return "\n\n~K" + (g_html_blocks.push(text)-1) + "K\n\n";
		}
		
		
		private static function _DoCodeSpans(text:String):String {
			//
			//   *  Backtick quotes are used for <code></code> spans.
			// 
			//   *  You can use multiple backticks as the delimiters if you want to
			//	 include literal backticks in the code span. So, this input:
			//	 
			//		 Just type ``foo `bar` baz`` at the prompt.
			//	 
			//	   Will translate to:
			//	 
			//		 <p>Just type <code>foo `bar` baz</code> at the prompt.</p>
			//	 
			//	There's no arbitrary limit to the number of backticks you
			//	can use as delimters. If you need three consecutive backticks
			//	in your code, use four for delimiters, etc.
			//
			//  *  You can use spaces to get literal backticks at the edges:
			//	 
			//		 ... type `` `bar` `` ...
			//	 
			//	   Turns to:
			//	 
			//		 ... type <code>`bar`</code> ...
			//
			
			/*
			text = text.replace(/
			(^|[^\\])					// Character before opening ` can't be a backslash
			(`+)						// $2 = Opening run of `
			(							// $3 = The code block
			[^\r]*?
			[^`]					// attacklab: work around lack of lookbehind
			)
			\2							// Matching closer
			(?!`)
			/gm, function(){...});
			*/
			
			text = text.replace(/(^|[^\\])(`+)([^\r]*?[^`])\2(?!`)/gm,
				function(wholeMatch:String,m1:*,m2:*,m3:*,m4:*,...args):String {
					var c:String = m3;
					c = c.replace(/^([ \t]*)/g,"");	// leading whitespace
					c = c.replace(/[ \t]*$/g,"");	// trailing whitespace
					c = _EncodeCode(c);
					return m1+"<code>"+c+"</code>";
				});
			
			return text;
		}
		
		
		private static function _EncodeCode(text:String):String {
			//
			// Encode/escape certain characters inside Markdown code runs.
			// The point is that in code, these characters are literals,
			// and lose their special Markdown meanings.
			//
			// Encode all ampersands; HTML entities are not
			// entities within a Markdown code span.
			text = text.replace(/&/g,"&amp;");
			
			// Do the angle bracket song and dance:
			text = text.replace(/</g,"&lt;");
			text = text.replace(/>/g,"&gt;");
			
			// Now, escape characters that are magic in Markdown:
			text = escapeCharacters(text,"*_{}[]\\",false);
			
			// jj the line above breaks this:
			//---
			
			//* Item
			
			//   1. Subitem
			
			//            special char: *
			//---
			
			return text;
		}
		
		
		private static function _DoItalicsAndBold(text:String):String {
			
			// <strong> must go first:
			text = text.replace(/(\*\*|__)(?=\S)([^\r]*?\S[*_]*)\1/g,
				"<b>$2</b>");
			
			text = text.replace(/(\*|_)(?=\S)([^\r]*?\S)\1/g,
				"<i>$2</i>");
			
			return text;
		}
		
		
		private static function _DoBlockQuotes(text:String):String {
			
			/*
			text = text.replace(/
			(								// Wrap whole match in $1
			(
			^[ \t]*>[ \t]?			// '>' at the start of a line
			.+\n					// rest of the first line
			(.+\n)*					// subsequent consecutive lines
			\n*						// blanks
			)+
			)
			/gm, function(){...});
			*/
			
			text = text.replace(/((^[ \t]*>[ \t]?.+\n(.+\n)*\n*)+)/gm,
				function(wholeMatch:String,m1:*,...args):String {
					var bq:String = m1;
					
					// attacklab: hack around Konqueror 3.5.4 bug:
					// "----------bug".replace(/^-/g,"") == "bug"
					
					bq = bq.replace(/^[ \t]*>[ \t]?/gm,"~0");	// trim one level of quoting
					
					// attacklab: clean up hack
					bq = bq.replace(/~0/g,"");
					
					bq = bq.replace(/^[ \t]+$/gm,"");		// trim whitespace-only lines
					bq = _RunBlockGamut(bq);				// recurse
					
					bq = bq.replace(/(^|\n)/g,"$1  ");
					// These leading spaces screw with <pre> content, so we need to fix that:
					bq = bq.replace(
						/(\s*<pre>[^\r]+?<\/pre>)/gm,
						function(wholeMatch:String,m1:String,...args):String {
							var pre:String = m1;
							// attacklab: hack around Konqueror 3.5.4 bug:
							pre = pre.replace(/^  /mg,"~0");
							pre = pre.replace(/~0/g,"");
							return pre;
						});
					
					return hashBlock("<blockquote>\n" + bq + "\n</blockquote>");
				});
			return text;
		}
		
		
		private static function _FormParagraphs(text:String):String {
			//
			//  Params:
			//    $text - string to process with html <p> tags
			//
			
			// Strip leading and trailing lines:
			text = text.replace(/^\n+/g,"");
			text = text.replace(/\n+$/g,"");
			
			var grafs:Array = text.split(/\n{2,}/g);
			var grafsOut:Array = [];
			
			//
			// Wrap <p> tags.
			//
			var i:Number;
			var end:int = grafs.length;
			for (i=0; i<end; i++) {
				var str:String = grafs[i];
				
				// if this is an HTML marker, copy it
				if (str.search(/~K(\d+)K/g) >= 0) {
					grafsOut.push(str);
				}
				else if (str.search(/\S/) >= 0) {
					str = _RunSpanGamut(str);
					str = str.replace(/^([ \t]*)/g,"<p>");
					str += "</p>";
					grafsOut.push(str);
				}
				
			}
			
			//
			// Unhashify HTML blocks
			//
			end = grafsOut.length;
			for (i=0; i<end; i++) {
				// if this is a marker for an html block...
				while (grafsOut[i].search(/~K(\d+)K/) >= 0) {
					var firstGroup:String = (/~K(\d+)K/).exec(grafsOut[i])[1];
					var blockText:String = g_html_blocks[firstGroup];
					blockText = blockText.replace(/\$/g,"$$$$"); // Escape any dollar signs
					grafsOut[i] = grafsOut[i].replace(/~K\d+K/,blockText);
				}
			}
			
			return grafsOut.join("\n\n");
		}
		
		
		private static function _EncodeAmpsAndAngles(text:String):String {
			// Smart processing for ampersands and angle brackets that need to be encoded.
			
			// Ampersand-encoding based entirely on Nat Irons's Amputator MT plugin:
			//   http://bumppo.net/projects/amputator/
			text = text.replace(/&(?!#?[xX]?(?:[0-9a-fA-F]+|\w+);)/g,"&amp;");
			
			// Encode naked <'s
			text = text.replace(/<(?![a-z\/?\$!])/gi,"&lt;");
			
			return text;
		}
		
		
		private static function _EncodeBackslashEscapes(text:String):String {
			//
			//   Parameter:  String.
			//   Returns:	The string, with after processing the following backslash
			//			   escape sequences.
			//
			
			// attacklab: The polite way to do this is with the new
			// escapeCharacters() function:
			//
			// 	text = escapeCharacters(text,"\\",true);
			// 	text = escapeCharacters(text,"`*_{}[]()>#+-.!",true);
			//
			// ...but we're sidestepping its use of the (slow) RegExp constructor
			// as an optimization for Firefox.  This function gets called a LOT.
			
			text = text.replace(/\\(\\)/g,escapeCharacters_callback);
			text = text.replace(/\\([`*_{}\[\]()>#+-.!])/g,escapeCharacters_callback);
			return text;
		}
		
		
		private static function _DoAutoLinks(text:String):String {
			
			text = text.replace(/<((https?|ftp|dict):[^'">\s]+)>/gi,"<a href=\"$1\">$1</a>");
			
			// Email addresses: <address@domain.foo>
			
			/*
			text = text.replace(/
			<
			(?:mailto:)?
			(
			[-.\w]+
			\@
			[-a-z0-9]+(\.[-a-z0-9]+)*\.[a-z]+
			)
			>
			/gi, _DoAutoLinks_callback());
			*/
			text = text.replace(/<(?:mailto:)?([-.\w]+\@[-a-z0-9]+(\.[-a-z0-9]+)*\.[a-z]+)>/gi,
				function(wholeMatch:String,m1:*,...args):String {
					return _EncodeEmailAddress( _UnescapeSpecialChars(m1) );
				}
			);
			
			return text;
		}
		
		
		private static function _EncodeEmailAddress(addr:String):String {
			//
			//  Input: an email address, e.g. "foo@example.com"
			//
			//  Output: the email address as a mailto link, with each character
			//	of the address encoded as either a decimal or hex entity, in
			//	the hopes of foiling most address harvesting spam bots. E.g.:
			//
			//	<a href="&#x6D;&#97;&#105;&#108;&#x74;&#111;:&#102;&#111;&#111;&#64;&#101;
			//	   x&#x61;&#109;&#x70;&#108;&#x65;&#x2E;&#99;&#111;&#109;">&#102;&#111;&#111;
			//	   &#64;&#101;x&#x61;&#109;&#x70;&#108;&#x65;&#x2E;&#99;&#111;&#109;</a>
			//
			//  Based on a filter by Matthew Wickline, posted to the BBEdit-Talk
			//  mailing list: <http://tinyurl.com/yu7ue>
			//
			
			// attacklab: why can't javascript speak hex?
			function char2hex(ch:String):String {
				var hexDigits:String = '0123456789ABCDEF';
				var dec:int = ch.charCodeAt(0);
				return(hexDigits.charAt(dec>>4) + hexDigits.charAt(dec&15));
			}
			
			var encode:Array = [
				function(ch:String):String{return "&#"+ch.charCodeAt(0)+";";},
				function(ch:String):String{return "&#x"+char2hex(ch)+";";},
				function(ch:String):String{return ch;}
			];
			
			addr = "mailto:" + addr;
			
			addr = addr.replace(/./g, function(ch:String,...args):String {
				if (ch == "@") {
					// this *must* be encoded. I insist.
					ch = encode[Math.floor(Math.random()*2)](ch);
				} else if (ch !=":") {
					// leave ':' alone (to spot mailto: later)
					var r:Number = Math.random();
					// roughly 10% raw, 45% hex, 45% dec
					ch =  (
						r > .9  ?	encode[2](ch)   :
						r > .45 ?	encode[1](ch)   :
						encode[0](ch)
					);
				}
				return ch;
			});
			
			addr = "<a href=\"" + addr + "\">" + addr + "</a>";
			addr = addr.replace(/">.+:/g,"\">"); // strip the mailto: from the visible part
			
			return addr;
		}
		
		
		private static function _UnescapeSpecialChars(text:String):String {
			//
			// Swap back in all the special characters we've hidden.
			//
			text = text.replace(/~E(\d+)E/g,
				function(wholeMatch:String,m1:String,...args):String {
					var charCodeToReplace:int = parseInt(m1);
					return String.fromCharCode(charCodeToReplace);
				}
			);
			return text;
		}
		
		
		private static function _Outdent(text:String):String {
			//
			// Remove one level of line-leading tabs or spaces
			//
			
			// attacklab: hack around Konqueror 3.5.4 bug:
			// "----------bug".replace(/^-/g,"") == "bug"
			
			text = text.replace(/^(\t|[ ]{1,4})/gm,"~0"); // attacklab: g_tab_width
			
			// attacklab: clean up hack
			text = text.replace(/~0/g,"");
			
			return text;
		}
		
		private static function _Detab(text:String):String {
			// attacklab: Detab's completely rewritten for speed.
			// In perl we could fix it by anchoring the regexp with \G.
			// In javascript we're less fortunate.
			
			// expand first n-1 tabs
			text = text.replace(/\t(?=\t)/g,"    "); // attacklab: g_tab_width
			
			// replace the nth with two sentinels
			text = text.replace(/\t/g,"~A~B");
			
			// use the sentinel to anchor our regex so it doesn't explode
			text = text.replace(/~B(.+?)~A/g,
				function(wholeMatch:String,m1:String,m2:*,...args):String {
					var leadingText:String = m1;
					var numSpaces:int = 4 - leadingText.length % 4;  // attacklab: g_tab_width
					
					// there *must* be a better way to do this:
					for (var i:int=0; i<numSpaces; i++) leadingText+=" ";
					
					return leadingText;
				}
			);
			
			// clean up sentinels
			text = text.replace(/~A/g,"    ");  // attacklab: g_tab_width
			text = text.replace(/~B/g,"");
			
			return text;
		}
		
		
		//
		//  attacklab: Utility functions
		//
		
		
		private static function escapeCharacters(text:String, charsToEscape:String, afterBackslash:Boolean = false):String {
			// First we have to escape the escape characters so that
			// we can build a character class out of them
			var regexString:String = "([" + charsToEscape.replace(/([\[\]\\])/g,"\\$1") + "])";
			
			if (afterBackslash) {
				regexString = "\\\\" + regexString;
			}
			
			var regex:RegExp = new RegExp(regexString,"g");
			text = text.replace(regex,escapeCharacters_callback);
			
			return text;
		}

		//noinspection JSUnusedLocalSymbols
		private static function escapeCharacters_callback(wholeMatch:String,m1:*,m2:*,m3:*,...args):String {
			var charCodeToEscape:int = m1.charCodeAt(0);
			return "~E"+charCodeToEscape+"E";
		}
	}// end of Showdown.converter
}