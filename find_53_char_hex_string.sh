#!/bin/bash
#
# 6. Find the 53-character hex string hidden as an HTML comment in the FormAPI documentation.

set -e

# Scrape all the HTML pages from the FormAPI docs using wget,
# then search for a hex string with exactly 53 characters

rm -rf /tmp/formapi_docs
mkdir /tmp/formapi_docs
cd /tmp/formapi_docs
wget --recursive --no-host-directories -A html "https://formapi.io/docs/"

echo; echo
echo "=> Searching for hex string with exactly 53 characters..."
echo
grep -REo '(^|[^0-9a-fA-F])[0-9a-fA-F]{53}([^0-9a-fA-F]|$)'

# => api/generate_pdf.html: 23a664f3b2721d119d85e3351324a26be965202db0af1d113a7f3
