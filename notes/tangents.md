# tangents

- [compile-php-thread-safe-and-pthreads.sh](https://gist.github.com/Divi/9696838)

### Unicorn (a Ruby web-server)

[Unicorn Design](http://unicorn.bogomips.org/DESIGN.html)

> Simplicity: Unicorn is a traditional UNIX prefork web server. No threads are used at all, this makes applications easier to debug and fix. When your application goes awry, a BOFH can just "kill -9" the runaway worker process without worrying about tearing all clients down, just one. Only UNIX-like systems supporting fork() and file descriptor inheritance are supported.

[I like Unicorn because it's Unix](http://2ndscale.com/rtomayko/2009/unicorn-is-unix)

> Unicorn is basically Mongrel (including the fast Ragel/C HTTP parser), minus the threads, and with teh Unix turned up to 11. That means processes. And all the tricks and idioms required to use them reliably.

[Deploying Rails Applications with Unicorn](https://devcenter.heroku.com/articles/rails-unicorn)

Early disclaimer:

> Heroku recommends using the Puma web server instead of Unicorn. If you are using Unicorn, your application is not protected against a slow client attack.

But mainly

> Unicorn forks multiple OS processes within each dyno to allow a Rails app to support multiple concurrent requests without requiring them to be thread-safe. In Unicorn terminology these are referred to as worker processes not to be confused with Heroku worker processes which run in their own dynos.
