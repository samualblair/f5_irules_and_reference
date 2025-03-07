# Name: Curl Shell (CLI) sample commands
# Author: Michael Johnson

# Can simulate other oauth requests, by intercepting and duplicating oauth style requests (with ? paramaters needed in URL)
curl -H "Cookie: site_cookie_1=abcdefhzykdsah; app_locale=en" -H "X-Forwarded-Host: www.example.com" -H "Host: privateserver.example.com" "https://privateserver.example.com:7443/application/sharing/oauth2/authorize/?client_id=auser&response_type=token&state=%7B%22portalUrl%22%3A%22https%3A%2F%2Fwww.example.com%2Fportal%22%7D&expiration=20160&redirect_uri=https%3A%2F%2Fwww.authexample.example.com%2Fhome%2Foauth-callback.html"

# Can add headers with curl -H
curl -H "Cookie: site_cookie_1=abcdefhzykdsah; app_locale=en" -H "X-Forwarded-Host: www.example.com" -H "Host: privateserver.example.com" "https://privateserver.example.com:7443/application/"
