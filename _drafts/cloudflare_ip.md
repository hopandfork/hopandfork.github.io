---
layout: post
title: "Unveil the real IP behind Cloudflare-protected domains (and how to avoid it)"
categories: ['computer_security', 'hacking', 'cloudflare', 'nmap']
author: alessandro_didiego
comments: true
---

#Unveil the real IP behind Cloudflare-protected domains (and how to avoid it)

[Cloudflare](https://www.cloudflare.com/) is a popular compay that provides several useful internet services, like content delivery networks, load balancers, DDoS protection and so on.

The best known service is the distributed domain name server that, among other things, acting like a reverse proxy hides the real location of a website. However, Cloudflare is not a magic wand; if not properly configured, **any web service could accidentally leak the real IP** in a number of ways.

In this article we will see a list of  procedures through which is possible to unveil the real IP behind a domain that uses the Cloudflare DNS protection system and how to become immune to them, plus a [nmap](https://nmap.org/) script written specifically to exploit one of these misconfigurations.

##Using Crimeflare
The first way to unmask a domain hidden by Cloudflare, is to check if *someone else has already done it for you*. 
[Crimeflare](http://www.crimeflare.com/) is a site that wants to *"uncover the bad guys hiding behind CloudFlare"*; to do so, it mantains a database of domain name - IP pairs collected in an undisclosed way (probably by mass IP scanning and reverse-DNS resolution; we'll cover this point later in this article).

Searching for the real IP behind a domain is as simple as writing the target address [in the bottom of this page](http://www.crimeflare.com/cfs.html) and pressing the "Search" button. A page with the desired result will be showed (if present in the database), plus some interesting informations.

![CrimeFlare, wrongly protected domain ](https://i.imgsafe.org/879b865b5a.png  "CrimeFlare, wrongly protected domain")

Sometimes, if there isn't a record in the database, a page with informations about the nameservers associated to the target domain is showed. Since every Cloudflare account is usually associated to a single pair of nameservers, clicking on the link at the bottom of the page a list of all domains using that particular pair will pop out. 
Chances are that one of the domain in that list is associted to the same account and it's in the CrimeFlare database.

![CrimeFlare, protected domain](https://i.imgsafe.org/879ba757ea.png  "CrimeFlare, protected domain")

###The Fix
If your domain was already indexed by CrimeFlare,  you should secure it as soon as possible applying all the fixes presented in the rest of this post. Once done, your best bet would be to request another IP from your host.


##Using DNS historical data
Almost any action on the Internet is constantly monitored by someone; it's no exception to the changes of domains resolutions.
There are a number of sites like [DNS Trails](http://dnstrails.com/) or [DNS History](http://dnshistory.org/) that keep track of the domains resolution over time. This means that if a domain now protected by Cloudflare was sometime in the past directly associated to the host's real IP, this information was registered somewhere.

Searching for a domain on DNS Trails, an hacker could in fact retrieve the server IP regardless of the Cloudflare protection.

![DNS Trails search](https://i.imgsafe.org/87fe9d97e9.png  "DNS Trails search")

###The Fix
Similarly to the previous case, you should secure the site as soon as possible and request another IP from your host. Don't even try to take down the data collected by services like DNS Trails; there are too many of such services and they have a lot of other useful legitimate applications. 

##DNS Bruteforcing
As we have previously said, Cloudflare acts as a Reverse Proxy to connect to a website, meaning that when a web browser tries to contact a remote website it in fact contacts a Cloudflare's CDN server to retrieve html pages, js scripts and so on.

![Cloudflare example](https://i.imgsafe.org/88a845f488.png  "Cloudflare example")

What we have not said yet, is that the Reverse Proxy only works for the HTTP and HTTPS protocols. This means that if a remote host is used as anything other than a web server, it can't be reached through the Cloudflare-protected address.

To overcome this need, the suggested way is to bypass Cloudflare's protection connecting to a not-cloudflare-protected record, like a subdomain.

![Cloudflare support](https://i.imgsafe.org/88cf711c8a.png  "Cloudflare support")

At this point, finding the real IP becomes a matter of guessing a unprotected subdomain, like ssh.example.com, ftp.example.com ...

Here comes into play a bruteforce DNS scanner like [**Fierce**](https://github.com/davidpepper/fierce-domain-scanner).
Fierce is *"a semi-lightweight scanner that helps locate non-contiguous IP space and hostnames against specified domains"*; while having several interesting features, the most famous is the "-dns" option that makes Fierce a powerful **DNS scanner and bruteforcer**. 

For example, the command

```fierce -dns uniroma2.it```

gives the following output:

```
DNS Servers for uniroma2.it:
	ns1.garr.net
	dns1.uniroma2.it
	dns.uniroma2.it

Trying zone transfer first...
	Testing ns1.garr.net
		Request timed out or transfer not allowed.
	Testing dns1.uniroma2.it
		Request timed out or transfer not allowed.
	Testing dns.uniroma2.it
		Request timed out or transfer not allowed.

Unsuccessful in zone transfer (it was worth a shot)
Okay, trying the good old fashioned way... brute force

Checking for wildcard DNS...
Nope. Good.
Now performing 2280 test(s)...
160.80.6.221	webhouse00.ccd.uniroma2.it
160.80.6.221	backup.uniroma2.it
160.80.6.59	oldmailbe.uniroma2.it
160.80.6.54	mailbe04.uniroma2.it
160.80.6.50	mailbe00.uniroma2.it
160.80.6.46	smtpauth.uniroma2.it
160.80.6.41	ricerca-nazionale.uniroma2.it. 
160.80.6.36	mx-03.uniroma2.it
160.80.6.33	unassigned.ccd.uniroma2.it
...

```

###The Fix
If you need to connect to the original server, just use a completly different domain associated to the same host or use your server's IP directly.

##Email headers IP leaking
If the target website has any form of user registration, chanches are that it has a mail service that sends user registration confirmation emails,  password changes notifications, password reset codes etcetera.
By default, most of the web serves uses the local email server to send such emails, causing the server's **IP to leak through email headers**.

![Email IP leak through headers](https://i.imgsafe.org/89765d2f35.png  "Email IP leak through headers")

Moreover, the email header could **disclose other useful information** about the target in the form of metadata, like the hosting company, the client used to send the email and other stuff like this. The key to access this source of information, is just to trigger the sending of an email.

###The Fix
This leakage of informations can be mitigated in at least two ways. One way would foresee the use of an external service, like SendGrid, Amazon SES, MaiChimp etc. to send email on behalf of your server.

Another way would consist in forwarding the emails to another server in your private network that has another unique public IP Address. Doing so, your web service would appear among the email headers with its local IP address, while your email relay would be identified by his (different) public IP.

##Making the server request a custom remote file
A lot of website often give the user the option to set a custom image as the user Avatar. More often than not, they offer the ability not only to directly upload an image, but also to give a remote address from which to retrieve te image. If this file is downloaded by the server, this opens the way for a new attack vector.

With some basic php lines and a small .htcaccess modification, it's in fact possible to create a link to an image that logs the IP address of anyone who tries to retrieve the resource:
```
 # add this line to .htcaccess
 
AddHandler application/x-httpd-php5 .jpg
```

```
<?php
// name this file ipgrab.php
 
$fh =@fopen("log.txt", "a+");
$timestamp = date('l jS \of F Y h:i:s A');
$hostname = @gethostbyaddr($_SERVER['REMOTE_ADDR']);
 
    @fwrite($fh, "\r\n$timestamp\r\n");
    @fwrite($fh, 'REMOTE_ADDR: '.$_SERVER['REMOTE_ADDR']."\r\n");
    @fwrite($fh, 'Host Name: '."$hostname\r\n");
    @fwrite($fh, 'HTTP_CLIENT_IP: '.$_SERVER['HTTP_CLIENT_IP']."\r\n");
    @fwrite($fh, 'HTTP_USER_AGENT: '.$_SERVER['HTTP_USER_AGENT']."\r\n");
     
fclose($fh);
// bait.png is the image to show when grabbing the ip
// give 755 permissions to bait.png
$im = imagecreatefrompng("bait.png");
header('Content-Type: image/jpeg');
imagepng($im);
imagedestroy($im);
?>

```

If an attacker doesn't want to go along all the mess of setting up an Apache server with just two files, he can even use a free and ready-to-go service like [Iplogger](http://iplogger.org/) to achieve the same results with even greater anonymity.

Of course the same goes for all the other types of file, like .txt, .doc etc.

###The Fix
Disable the remote retrieving of files from unknown sources making a whitelist of trusted sources, or, if you feel merciless, permit only the classic HTTP POST upload.

##Mass Scanning an entire webhost
Let's say that a target took all the necessary countermeasures to mitigate the attacks described so far. Well, as far as the website is directly reachable from its public IP, it's still possible to retrieve it, even if in a more daring way. How? Scanning the whole web hosting's network, of course!

Given two different addresses or domains, if for example they both return the same page title when contacted, unless the title it's something common like "index of /", chances are good that they are two entrypoint to the same resources, i.e. they both point to the same web page. What if we compare the page title returned by the cloudflare-protected domain with a list of IP addresses?

Let us assume for example that, during the Reconnaissance phase of Penetration Testing, it was discovered that a target website, although hidden by Cloudflare, it's actually hosted on *OVH*. This means that if the site is directly accessible through its IP, the information we seek is somewhere in the OVH address space.

With [some simple Google search](http://bfy.tw/8jpD), we can easly find that OVH has two Autonomous System associated, [AS16276](https://ipinfo.io/AS16276) and [AS35540](http://ipinfo.io/AS35540). These two AS together form a collection of amost **2 millions(!) ip addresses**. [Using this simple nmap script](https://github.com/alessandrodd/nmap-resources/blob/master/http-title-matcher.nse), in conjunction with a 100Mbps connection, it's possible to do expression matching on the title of about 3600 websites-per-minute on an Intel i3/4GB machine with the following command:

```sudo nmap -p 80,443 192.168.0.0/16 --min-hostgroup 4096 --min-parallelism 1024 --script=./http-title-matcher --script-args 'http-title-matcher.match=hello world, http-title-matcher.case-insensitive' -oX my_scan_dump.xml```


Where:

     - *-p 80,443*  =>  scans ports 80 and 443 (default for HTTP and HTTPS)
     - *192.168.0.0/16*  =>  is target subnet 
     - *--min-hostgroup 4096 --min-parallelism 1024*  =>  maximizes parallel execution (set lower values or omit for more reliability)
     - *--script=./http-title-matcher*  =>  loads http-tite-matcher script from the current folder
     - *--script-args 'http-title-matcher.match=hello world, http-title-matcher.case-insensitive'*  =>  match any website that contains "hello world" in the title, case insensitive
     - *-oX my_scan_dump.xml*  =>  saves results in an handy xml file
     
For other options like reverse DNS expression matching or url specification [check the main page](https://github.com/alessandrodd/nmap-resources).
Doing the maths, in less than 5 hours on average it could be possible for a determined hacker to track down the victim's real IP address.

###The Fix
One possible way to prevent this attack, would be to disallow non-Cloudflare IPs from connecting to your webserver; you can therefore setup a whitelist containing all Cloudflare's IPs ([here you can find the complete always-updated list](https://www.cloudflare.com/ips/)) and other trusted IPs (like the ones used by the server admins) denying any possibility of identifying the host IP using the technique described above.

##Conclusion
As always in the computer security field, there is no "magic tool" to effectively protect a resource; every action should be taken wisely and only with the right domain knowledge a security measure may be considered "successfully applied". At least until someone who knows more comes along.

*Comments are welcome, feel free to suggest any correction or missing methods!*
