
# cURL sample command structure
For synthetic testing or building http based monitoring.
This F5 link does a good job of highlighting some of the nuances when debugging http monitors [K000158134](https://my.f5.com/manage/s/article/K000158134)

## Common monitor Recreations in curl for monitors in BIG-IP

### Default BIG-IP HTTP and HTTPS
The default HTTP and HTTPS monitors do not send a HTTP Version , so 'GET /' , instead of 'GET / HTTP1.0' or something.
This mode is not well formed , not HTTP 1.0 , and does not support specifically response headers it just accepts any data from the server.
Some servers will not accept this, just as some servers may not accept HTTP1.0 and only HTTP1.1 and higher.
In addition, some servers will accept this, but if they respond with error code and no data, monitors may fail.
Especially when we look at differences in LTM monitors that just start reviewing response vs GTM monitors that check the status code first.

Generally recommended to use well formed custom monitors whenever possible, even if just well formed message such as "GET / HTTP1.0" or "GET / HTTP1.1 "Host: www.example.com".
The main reason to consider HTTP 1.0 over 1.1 is the lack of need for a HOST header, but HTTP 1.1 and beyond should have a host header.
HTTP 2 and HTTP 3 use different headers or pseudo header 'authority' but should.


## Customized HTTP and HTTPS monitors
These can be well re-created with curl, with various parameters.

### A Monitor that is very similar to basic
```bash
curl -v http://198.51.100.50:1234/ --http1.0 -H "Host:" -H "Accept:" -H "User-Agent:"
```
BIG-IP Monitor equivalent
```text
GET / HTTP/1.0\r\n\r\n
```

### A Monitor that is very similar to basic
```bash
curl -v http://198.51.100.50:1234/ --http1.1 -H "Host: myapp.example.com" -H "Accept:" -H "User-Agent:"
```
BIG-IP Monitor equivalent
```text
GET / HTTP/1.1\r\nHost: myapp.example.com\r\n\r\n
```

### A slightly more complicated monitor , A well formed and recommended style monitor
```bash
curl -v http://198.51.100.50:1234/ --http1.1 -H "Host: myapp.example.com" -H "Connection: Close" -H "Accept:" -H "User-Agent: BIG-IP Monitor"
```
BIG-IP Monitor equivalent
```text
GET / HTTP/1.1\r\nHost: myapp.example.com\r\nConnection: Close\r\nUser-Agent: BIG-IP Monitor\r\n
```

###  Some Servers will require accept headers to be present.
Just make sure what you use is valid. Something like "Accept: text/html" is great, but may want it more generic "Accept: */*"
A slightly more complicated monitor , A well formed and recommended style monitor
```bash
curl -v http://198.51.100.50:1234/ --http1.1 -H "Host: myapp.example.com" -H "Connection: Close" -H "Accept: */*" -H "User-Agent: BIG-IP Monitor"
```
BIG-IP Monitor equivalent
```text
GET / HTTP/1.1\r\nHost: myapp.example.com\r\nConnection: Close\r\nAccept: */*\r\nUser-Agent: BIG-IP Monitor\r\n\r\n
```


### Worth Noting GTM monitors check code first then string
For a GTM HTTP monitor, make sure the code you get back is acceptable and in allowed list, then also make sure the string is acceptable.
The code should still be matchable in the string even for GTM.

LTM just jumps straight to string parsing.



### HTTP2 and HTTP3 on BIG-IP Slightly different

A default curl , which will try to negotiate http2 (h2) and/or http3 (h3)
```bash
curl -v http://198.51.100.50:1234/ -H "Host: myapp.example.com" -H "Connection: Close" -H "Accept:" -H "User-Agent: BIG-IP Monitor"
```

A forced HTTP 2 monitor - on BIG-IP this would be a dedicate monitor type
```bash
curl -v http://198.51.100.50:1234/ --http2 -H "Host: myapp.example.com" -H "Connection: Close" -H "Accept:" -H "User-Agent: BIG-IP Monitor"
```

A forced HTTP 3 monitor - on BIG-IP this would be a dedicate monitor type, may not be supported yet as of v21
```bash
curl -v http://198.51.100.50:1234/ --http3 -H "Host: myapp.example.com" -H "Connection: Close" -H "Accept:" -H "User-Agent: BIG-IP Monitor"
```

### Notes regarding regex

Helpful for monitors or other tests
```
# RE2 Regular Expression for matching all http versions - this is a full string match due to $
^HTTP\/[1-3](\.[0-1])?$
# RE2 Regular Expression matching and allows for partial match of line
^HTTP\/[1-3](\.[0-1])?
# A Good example of Valid RE2 Regular Expression expecting a 200 OK match
^HTTP\/[1-3](\.[0-1])? 200 OK
```