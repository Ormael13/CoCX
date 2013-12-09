#!/bin/bash 

STAGE="$1"

DIRECTORY=../binRepo

if [ "$STAGE" = "setup" ]; then
	echo "Setup stage"

	if [ ! -d "$DIRECTORY" ]; then
		git clone "git@github.com:herp-a-derp/CoC-Alpha.git" ../binRepo
	else
		(cd ../binRepo && git pull)
		(cd ../binRepo && git reset --hard HEAD)
		(cd ../binRepo && rm CoC*.swf)
		(cd ../binRepo && rm CoC*.apk)
		(cd ../binRepo && git add -u .)

	fi

fi

if [ "$STAGE" = "commit" ]; then
	echo "Commit stage"
	(cd ../binRepo && git add CoC*.swf)
	(cd ../binRepo && git add CoC*.apk)
	(cd ../binRepo && git commit CoC* -m "Automated build commited by BuildBot CoC-Builder")
	(cd ../binRepo && git push)

fi

echo "Complete"