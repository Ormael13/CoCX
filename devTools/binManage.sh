#!/bin/bash 

STAGE="$1"

DIRECTORY=../binRepo

if [ "$STAGE" = "setup" ]; then
	echo "Setup stage"

	if [ ! -d "$DIRECTORY" ]; then
		git clone "git@github.com:herp-a-derp/CoC-Alpha.git" ../binRepo
	else
		(cd ../binRepo && git fetch origin)
		(cd ../binRepo && git reset --hard origin/master)
		(cd ../binRepo && rm CoC*.swf)
		(cd ../binRepo && rm CoC*.apk)

	fi

fi

if [ "$STAGE" = "commit" ]; then
	echo "Commit stage"
	(cd ../binRepo && git add -u)
	(cd ../binRepo && git add CoC*.swf)
	(cd ../binRepo && git add CoC*.apk)
	(cd ../binRepo && git commit -m "Automated build commited by BuildBot CoC-Builder")
	(cd ../binRepo && git push)

fi

echo "Complete"