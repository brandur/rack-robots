module Rack
  class Robots
    def initialize(app)
      @app = app
    end

    def call(env)
      if env["REQUEST_PATH"] == "/robots.txt" &&
        %w{1 true yes}.include?(ENV["DISABLE_ROBOTS"])
          [200, { 'Content-Type' => 'text/plain' }, <<-eos]
# this is a staging environment. please index the main site instead.
User-agent: *
Disallow: /
          eos
      else
        @app.call(env)
      end
    end
  end
end
