

import re
import os
import os.path

# Ok, this is kind of a mess, but it currently seems to work without major crashes or causing any 
# invalid code output, at least as far as I have been able to check.

# (choices[\(\)\w,\- \"]+?\W)(120)(\W)

def cleanEventNumbers():

	funcFind = re.compile(r"(if\(eventNo == \d*?\) )\{\W*")
	funcExtr = re.compile(r"if\(eventNo == (\d*)\) (\w*)\(\)")

	eventF = open("./includes/doEvent.as", "r")
	eventS = eventF.read()
	eventF.close()

	eventS = funcFind.sub(r"\1", eventS)

	print "done"
	#print eventS
	res = funcExtr.findall(eventS)
	res = dict(res)
	print res
	#Ok, now we have a eventNo <-> function name dictionary
	

	simpleCRe = re.compile(r"[ 	]simpleChoices\([\w\"\ \,\?]*?\);")
	choicesRe = re.compile(r"choices\([\w\"\ \,\?]*?\);")
	doYesNoRe = re.compile(r"doYesNo\([\w\"\ \,\?]*?\);")
	doNextRe = re.compile(r"doNext\(\d*?\);")

	searchREs = [simpleCRe, choicesRe, doYesNoRe, doNextRe]

	filelist = os.listdir("./includes")
	print filelist
	for filename in filelist:
		if filename.endswith(".as") and not filename.find("doEvent")+1:			#Iterate over all the .as files in ./includes, and skip the doEvent file
			#print filename
			with open(os.path.join("./includes", filename), "r") as fileH:
				tmp = fileH.read()

			# BRUTE FORCE IT. BECAUSE LAZY
			tmpO = tmp

			for repRe in searchREs:
				#print repRe.pattern
				insertionPoint = 0
				while repRe.search(tmp[insertionPoint:]):
				
					m = repRe.search(tmp[insertionPoint:])
					start, length = m.start()+insertionPoint, len(m.group())

					prefix, call, postfix = tmp[:start], tmp[start:start+length], tmp[start+length:]

					oldCall = call
					for key, value in res.iteritems():
						if key in call:
							#print key, value
							call = call.replace(key, value)

					if oldCall != call:		
						print "Old:", oldCall
						print "New:", call

					tmp = prefix+call+postfix

					insertionPoint = start+length
			if len(tmp)-len(tmpO) != 0:
				print len(tmpO), len(tmp)
				print "Length Delta", len(tmp)-len(tmpO) 

				#with open(os.path.join("./includes", filename), "w") as fileH:
				#	tmp = fileH.write(tmp)


#
def cleanStaleDoEventIfs():

	numExtr = re.compile(r"if\(eventNo == (\d*)\)")


	with open("./includes/doEvent.as", "r") as eventF:
		eventS = eventF.read()


	filelist = os.listdir("./includes")
	files = []

	#Pull all the as files into memory. 
	for filename in filelist:
		if filename.endswith(".as") and not filename.find("doEvent")+1:		
			with open(os.path.join("./includes", filename), "r") as fileH:
				tmp = fileH.read()
			files.append(tmp)


	for match in numExtr.finditer(eventS):
		
		num = match.group(1)

		numUnused = True

		for fContents in files:

				if num in fContents:
					#print "num exists", num
					numUnused = False
					break


		if numUnused:
			start, length = match.start(), len(match.group())


			prefix, call, postfix = eventS[:start], eventS[start:start+length], eventS[start+length:]

			#num = call.split()[-1].rstrip("\)")

			print start, length, num

			if (num in prefix) or (num in postfix):
				print "used elsewhere in doEvent.as"
			else:
				call = call.replace("eventNo", " false ")
				eventS = prefix+call+postfix

	with open("./includes/doEvent.as", "w") as eventF:
		eventF.write(eventS)

def getFlagDict():
	with open("FlagDictionary.txt", "r") as fd:
		lines = fd.readlines()
	ret = {}
	for line in lines:
		num, desc = line.split("=", 1)
		desc = desc.split("/")[-1]
		num = num.rstrip().lstrip()
		desc = desc.rstrip().lstrip()
		ret[int(num)] = desc

	return ret


def cleanFlags():
	with open("flagDefsNamed.as", "r") as fA:
		good = fA.readlines()

	maxLen = 0
	targetLen = 70
	out = {}

	flagDict = getFlagDict()

	for line in good:
		if "=" and ";" in line:

			prefix, postfix = line.split("=", 1)
			prefix = prefix.rstrip().lstrip()
			postfix = postfix.rstrip().lstrip()

			num_s, comment = postfix.split(";")
			comment = comment.split("/")[-1]
			if maxLen < len(prefix):
				maxLen = len(prefix)

			num_i = int(num_s)

			tmp = prefix + " "*(targetLen - len(prefix))
			tmp += "=" + " "*(5-len(num_s)) + num_s + "; // " + comment
			if num_i in flagDict:
				if not flagDict[num_i] in tmp:
					tmp += flagDict[num_i]
				else:
					print "In tmp already = ", flagDict[num_i]

			out[num_i] = tmp


		else:
			if line.rstrip().lstrip() != "":
				print "Wut:", line
	print "done"
	print maxLen
	outL = []

	for x in range(3000):
		if x in out:
			outL.append(out[x])
		else:
			prefix = "const UNKNOWN_FLAG_NUMBER_%05d:int" % x
			tmp = prefix + " "*(targetLen - len(prefix))
			tmp += "=" + " "*(5-len(str(x))) + str(x) + ";"

			if x in flagDict:
				tmp += " // %s" % flagDict[x]
			outL.append(tmp)

	with open("flagDefs.as", "w") as outF:
		for x in outL:
			#print x
			outF.write("%s\n" % x)

	#for key, value in out.iteritems():
	#	print key, value


def insertFlags():

	with open("flagDefs.as", "r") as flagsF:
		lines = flagsF.readlines()

	flags = {}
	for line in lines:
		prefix, postfix = line.split("=", 1)
		prefix = prefix.rstrip().lstrip().split()[-1].split(":")[0]
		postfix = postfix.rstrip().lstrip().split(";")[0]
		print postfix, prefix
		flags[postfix] = prefix


	#Ok, now we have a eventNo <-> event number macro

	flagRE = re.compile(r"flags\[(\d*?)\]")


	

	
	filelist = os.listdir("./includes")
	print filelist
	flagNum = 0
	for filename in filelist:
		if filename.endswith(".as"):			#Iterate over all the .as files in ./includes, and skip the doEvent file
			with open(os.path.join("./includes", filename), "r") as fileH:
				tmp = fileH.read()

			# BRUTE FORCE IT. BECAUSE LAZY
			tmpO = tmp

			insertionPoint = 0
			while flagRE.search(tmp[insertionPoint:]):
			
				m = flagRE.search(tmp[insertionPoint:])
				start, length = m.start(1)+insertionPoint, len(m.group(1))

				# print m.group(), m.group(1)
				insertionPoint = start+length
				flagNum += 1

				prefix, call, postfix = tmp[:start], tmp[start:start+length], tmp[start+length:]

				oldCall = call
				call = call.replace(call, flags[call])

				# if oldCall != call:		
				# 	print "Old:", oldCall
				# 	print "New:", call

				tmp = prefix+call+postfix
			if len(tmp)-len(tmpO) != 0:
				print filename
				print len(tmpO), len(tmp)
				print "Length Delta", len(tmp)-len(tmpO) 

			with open(os.path.join("./includes", filename), "w") as fileH:
				tmp = fileH.write(tmp)
	'''
				
				insertionPoint = start+length

			print len(tmpO), len(tmp)
			print "Length Delta", len(tmp)-len(tmpO) 


	'''
	print "Total Integer flag indices:", flagNum



def functionYoink():

	funcs = {}

	flagRE = re.compile(r"function ([\w]*?)\(")
	filelist = os.listdir("./includes")
	print filelist
	flagNum = 0
	for filename in filelist:
		if filename.endswith(".as"):			#Iterate over all the .as files in ./includes, and skip the doEvent file
			with open(os.path.join("./includes", filename), "r") as fileH:
				tmp = fileH.read()
				print "Functions in file %s:" % filename
				for item in flagRE.findall(tmp):
					print "	%s" % item

					nameLen = len(item)

					if nameLen in funcs:
						funcs[nameLen].append(item)
					else:
						funcs[nameLen] = [item]

	for x in range(250):
		if x in funcs:
			print "Name length = ", x
			for name in funcs[x]:
				print "	%s" % name


if __name__ == "__main__":

	print "OMG WE'S BREAKIN STUF!!111one!"

	cleanEventNumbers()
	#cleanStaleDoEventIfs()

	#cleanFlags()

	#insertFlags()
	#functionYoink()
