import re
import os
from repList import repStrings
###################################################################
def replaceInFile(fname):
	with open(fname,'r') as f:
		text = f.read()
	for rep, num in repStrings:
		regOrig = "dungeonLoc *(=|==|>|<|>=|<=|!=) *" + num + "([^0-9-])"
		regTo = "dungeonLoc \g<1> " + rep + "\g<2>"
		text = re.sub(regOrig, regTo, text)
	with open(fname,'w') as f:
		f.write(text)

def getFileList(fileDir):
	fList = list()
	for root, dirs, files in os.walk(fileDir):
		for fname in files:
			if ".as" in fname:
				fList.append(root + "/" + fname)
	return fList
###################################################################
repDir = "./classes"

for f in getFileList(repDir):
	replaceInFile(f)
