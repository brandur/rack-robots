module Rack
  class Robots
    def initialize(app)
      @app = app
    end

    def call(env)
      if env["REQUEST_PATH"] == "/robots.txt"
        status, body = if %w{1 true}.include?(ENV["DISABLE_ROBOTS"])
          [200, <<-eos]
# this is a staging environment. please index the main site instead.
User-agent: *
Disallow: /
          eos
        else
          [404, "Not found"]
        end
        [status, { 'Content-Length' => body.length,
          'Content-Type' => 'text/plain' }, body]
      else
        @app.call(env)
      end
    end
  end
end
