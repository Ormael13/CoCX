

import re
import os
import os.path


files = ["CoC_0.8.2b1.swf_as-MainTimeline.as", "CoC_0.8.3c1.swf_as-MainTimeline.as"]

# Find function declarations
functionSearch = re.compile("[ 	]*?public (?=function [\w_]*?\([\w: ]*?\))")	# Woot! Positive lookahead! Because regexes aren't annoying enough already


def sortFileContents():

	doSort = True

	for fileName in files:


		with open(fileName, "r") as fp:
			contents = fp.read()

			#print functionSearch.findall(contents)
			contentL = functionSearch.split(contents)
			
			print "Found functions: ", len(contentL)

			if doSort:
				print "doing file sort"
				
				contentL.sort()
				print len(contentL)


				with open(fileName+".sort.as", "w") as fo:
					for item in contentL:
						fo.write("%s" % item.rstrip().lstrip())
						fo.write("\n\\\\-----------------------------------------------------\n function ")

if __name__ == "__main__":

	print "OMG WE'S BREAKIN STUF!!111one!"

	sortFileContents()