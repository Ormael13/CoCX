
import sys
import re
import os
import os.path

def getImageIDList():

	r"init01Names\([\"']\w*[\"'], [\"']\w*[\"'], [\"'](\w+)[\"'], [\"']\w?[\"'], plural=false)"

	imgTagRe        = re.compile(r"images\.showImage\([\"']([\w\d-]+)[\"'](?:,.*?)?\)")
	monsterNameRe   = re.compile(r"this\.imageName\s?=\s?[\"'](\w+)[\"'];?")
	ret = set()

	scanPath = "../"
	for root, dirs, files in os.walk(scanPath):
		#print root, dir#, files
		for fileN in files:
			if fileN.endswith(".as"):
				wholePath = os.path.join(root, fileN)
				print "Scanning file: ", wholePath
				with open(wholePath, "r") as fp:
					cont = fp.read()
					items = set(imgTagRe.findall(cont))

					ret.update(items)

					monsterNames = monsterNameRe.findall(cont)
					if monsterNames:
						for name in monsterNames:
							name = "monster-%s" % name
							ret.add(name)

	ret.add("monster-hollispawn")  # Hack because matching this would be a giant pain in the ass

	print "Found %s image IDs" % len(ret)
	return ret


def genFile():


	imageIDs = getImageIDList()
	imageIDs = list(imageIDs)
	imageIDs.sort()

	extensions = ["png", "jpg", "jpeg", "gif"]



	#print imageIDs

	# Crapping out XML using string manipulation because FUCK YOU
	ret = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\n"
	ret += "	<Images>\n"
	for item in imageIDs:
		for extension in extensions:
			itemClean = item.rstrip().lstrip()
			ret += "		<Image id=\"%s\">./img/%s.%s</Image>\n" % (itemClean, itemClean, extension)

	ret += "</Images>"
	#print ret

	ret = ""
	ret += '<?xml version="1.0" encoding="utf-8"?>\n'
	ret += '	<Images>\n'
	ret += '		<ImageList>\n'
	for imId in imageIDs:
		ret += '			<ImageSet id="%s">\n' % imId
		ret += '				<ImageFile>./img/%s</ImageFile>\n' % imId
		ret += '				<ImageFile>./img/%s_1</ImageFile>\n' % imId
		ret += '			</ImageSet>\n'
	ret += '		</ImageList>\n'
	ret += '		<ExtensionList>\n'
	ret += '			<ExtensionType>png</ExtensionType>\n'
	ret += '			<ExtensionType>jpg</ExtensionType>\n'
	ret += '			<ExtensionType>jpeg</ExtensionType>\n'
	ret += '			<ExtensionType>gif</ExtensionType>\n'
	ret += '		</ExtensionList>\n'

	ret += '	</Images>\n'


	with open("images.xml", "w") as fp:
		fp.write(ret)

if __name__ == "__main__":
	genFile()
