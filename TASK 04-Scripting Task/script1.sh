#! /bin/bash

http_code=$(curl -o /dev/null -s -w"%{http_code}" https://www.guvi.in)

echo "https response code: $https_code"

if [ $http_code -ge 200 ] && [ $http_code -lt 300 ]; then
	echo "success the website is reacheable."
else
	echo "failed the website is not reacheable. "
fi

