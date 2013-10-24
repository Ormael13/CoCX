

import re
import os
import os.path


files = ["CoC_0.8.2b1.swf_as-MainTimeline.as", "CoC_0.8.3c1.swf_as-MainTimeline.as"]

def sortFileContents():

	for fileName in files:


		with open(fileName, "r") as fp:
			contents = fp.read()

			contentL = contents.split("function")		# WAAAAAAAYYYY not robust enough, currently does lots of messy stuff like split when there is a string containing 
														# "function", in addition to actual function declarations.
														# Dammit, I don't want to have to write a parser.
			contentL.sort()
			print len(contentL)


			with open(fileName+".sort.as", "w") as fo:
				for item in contentL:
					fo.write("%s" % item.rstrip().lstrip())
					fo.write("\n\\\\-----------------------------------------------------\n function ")

if __name__ == "__main__":

	print "OMG WE'S BREAKIN STUF!!111one!"

	sortFileContents()