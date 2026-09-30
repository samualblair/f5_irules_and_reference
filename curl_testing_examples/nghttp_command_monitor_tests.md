Beginning in BIG-IP 14.1.0, you can also use nghttp to verify the health of the back-end server. 
nghttp (Next Gen HTTP) can support HTTP2 and HTTP3 testing.

To do so, use the following command syntax:
```
nghttp -ynv https://<server_IP_address>:<port number>
```

