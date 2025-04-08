# F5 iRule Scripts and Related References 
[![F5-Cloud-Docs](https://img.shields.io/badge/F5_Cloud_Docs-red)](https://clouddocs.f5.com/)
[![F5-TMSH-Reference](https://img.shields.io/badge/F5_TMSH_Reference-red)](https://clouddocs.f5.com/cli/tmsh-reference/latest/)
[![F5-iRules-Home](https://img.shields.io/badge/F5_iRules_Home-red)](https://clouddocs.f5.com/api/irules/)
[![cURL](https://img.shields.io/badge/cURL-8.7.1|latest-blue)](https://curl.se/download.html)

A Collection of F5 iRule Scripts
Additional Reference Material, related and useful also included.

## Sections

### Rewrite, Redirect, and Directing Traffic
These iRules expect HTTP proxy functionailty (L7 HTTP Proxy).
Some crossover functionailty exists in these categories:

* uri_path_and_host_rewrites

    Rules focus on deployments that require internal and external names to be different, but updated on the fly by the ADC/LB (not handled by the server/application)

* redirect

    Rules that focus on redirects, in some cases also handling rewriting of URI or headers.

* directing_traffic

    Rules that focus on supporting Application (URI) routing, forwarding specific sub-sites to specific pools, etc.

### TCP 
These irules only require L4 TCP proxy.
Catch-all category of L4 TCP irules, currently including 'Proxy' Protocol support.

* tcp_irules

    Proxy Protocol is a good alternative for L7 HTTP X-Forwarded-For insertion type behavior (a way to signal to back-end server / pool-memebers original Source IP after SNAT has occured). Unlike L7 HTTP Header insertion, this must be cordinated with pool members or it will break connections (server explicitly must be expecting it, cannot just ignore it).

### HTTP modifications
These iRules expect HTTP proxy functionailty (L7 HTTP Proxy).

* http_headers

    Common http header modifications that may be desirable, for improving security or resolving application issues on the fly.

* synthetic_responses

    Some situations benifit from the ADC/LB responding to traffic requests directly and not trying to forward, or outright reject requests. One example is responding to favicon requests (which will continue to occur, and log distracting errors if not responded to cleanly).

## Others

* smtp

    Not commently used, but irules for working with SMTP (mail) in various situations.

* debug_logging

    Example irules for logging, either temporary (debug) or for longer term HSL deployments to external log servers.

* curl_testing_examples

    As the name sugests, this is not irules but simply some reference examples of cURL tool usage for testing. cURL is available in F5 bash shell, as well as many Linux systems by default, it is also easily obtainable for other OSes.

## Authors
Michael Johnson ([@samualblair](https://github.com/samualblair))

## Versioning
[![CalVer](https://img.shields.io/static/v1?label=CalVer&message=YY.0M.0D)](https://calver.org/)

* 2025.04.08 - General release
