---
layout: post
title: "Run a Redis server in one minute for development"
categories: Cloud
author: gabriele_russorusso
comments: true
---

Today I needed to run an application which generates data and stores them
into **Redis**. I had never run a Redis server on my machine and didn't want to
spend much time configuring it, since that app was just a component in a larger
system I had to debug.

**Docker** did the job. I pulled the official Redis 3.0.x image:

	docker pull redis

and started an instance with:

	docker run --name redisServer -d -p 6379:6379 redis:3.0

The server was then listening on port `6379` of `localhost`. If you later need to
flush all stored data:

	docker exec -it redisServer redis-cli FLUSHALL

That's all! Nothing magic, but useful.
