rack-robots
===========

Rack middleware that denies all robots for staging and development environments.

Usage
-----

Flag your staging and development environments:

``` bash
export DISABLE_ROBOTS=true
```

In a `config.ru` or equivalent:

``` ruby
use Rack::Robots
run Sinatra::Application
```

Testing
-------

``` bash
rake test
```
