
# cURL sample command structure
For syntetic testing or building http based monitoring.
A good reference post is https://community.f5.com/discussions/technicalforum/curl-usage/330942 , some of the wording below taken from that post.

## Simple Example
A simple curl command to check, whether your HTTP service works as you want would be
```
curl -vk https://<IP of your server>[:<Port of your Service>]<URI of your Service>
```
This would look like:
```bash
curl -vk https://198.51.100.50/path/to/my/app
```

## More Examples

This would result in an HTTP request
```
GET /path/to/my/app HTTP/1.1 Host: 192.168.10.15 Connection: keep-alive ...
```

If your server uses name-based Virtual Hosts, you have to adjust the Host-header field, to get the correct response:
```bash
curl -vk https//198.51.100.50/path/to/my/app -H "Host: myapp.example.com"
```

You can set more custom headers with \`-H\`, if necessary.

cURL can only be used within the advanced shell (Bash). A good practice to check for the health status of your app depends on you. A simple HTTP monitor, which checks the response code of your app is better than a simple tcp check, i.e.
```
HTTP/1.(0|1) (200|404|403)
```
This would check for a HTTP/1.0 or HTTP/1.1 response, accepting response codes 200, 404 and 403 - for whatever reason this may make sense...

A better approach is a built-in health check in your applications, where the application owner has created an health endpoint, which is callable via HTTP, i.e.

```bash
curl -vk https//198.51.100.50/status/health
```

returns
```
HTTP/1.1 200 OK ... Content-Type: application/json {"status": "ok"}
```

# If debugging / details are needed
Can use \'-v\'
```bash
curl -v https://198.51.100.50/path/to/my/app
```

If testing to server without valid cert (or if using IP so cert is not valid to request) can override cert check with \'-k\'
```bash
curl -vk https://198.51.100.50/path/to/my/app
```

Can also use \'-I\' to use HEAD instead of normal GET request, so only headers are obtained and not unnecesary body data.
```bash
curl -Ik https://198.51.100.50/path1/path2
```

Can use --resolve to override normal dns lookup on system.
This can be a nice alternative to overriding cert (assuming cert is present and valid) and also allows host header to be automatically applied.
Scheme must match, expected port and hostname or it will not perform override:
```bash
curl --location https://www.example.com:443/ --resolve domain.example.com:10.44.204.225
curl --location https://www.example.com:8443/ --resolve domain.example.com:8443:10.44.204.225
curl --location http://www.example.com:8080/ --resolve domain.example.com:8080:10.44.204.225
```

Can alsways add Headers manually with one or more \'-H\', several of these would be auto-added normally (user agent, host, etc.)
```bash
-H "Host: domain.example.com"
-H "User-Agent: curl/8.7.1"
-H "Accept: */*"
-H "Accept: application/json" 
-H "Content-Type: application/json"
-H "Authorization: Bearer xxxxxxxxxxxxxx"
```

# Can even simulate other oauth requests, by intercepting and duplicating oauth style requests (with ? paramaters needed in URL)
```bash
curl -H "Cookie: site_cookie_1=abcdefhzykdsah; app_locale=en" -H "X-Forwarded-Host: www.example.com" -H "Host: privateserver.example.com" "https://privateserver.example.com:7443/application/sharing/oauth2/authorize/?client_id=auser&response_type=token&state=%7B%22portalUrl%22%3A%22https%3A%2F%2Fwww.example.com%2Fportal%22%7D&expiration=20160&redirect_uri=https%3A%2F%2Fwww.authexample.example.com%2Fhome%2Foauth-callback.html"
```
