require "test_helper"

describe Rack::Robots do
  def app
    ->(env) { $env = env ; [200, {}, ""] }
  end

  def call(env = {})
    Rack::Robots.new(app).call(env)
  end

  it "denies robots" do
    ENV["DISABLE_ROBOTS"] = "true"
    status, headers, response = call("REQUEST_PATH" => "/robots.txt")
    status.must_equal(200)
    headers.must_equal({ 'Content-Length' => response.length.to_s,
      'Content-Type' => 'text/plain' })
    response.must_match(/Disallow: \//)
  end

  it "denies robots when configured with 1" do
    ENV["DISABLE_ROBOTS"] = "1"
    status, headers, response = call("REQUEST_PATH" => "/robots.txt")
    response.must_match(/Disallow: \//)
  end

  it "renders 404 when not true" do
    ENV["DISABLE_ROBOTS"] = "false"
    status, headers, response = call("REQUEST_PATH" => "/robots.txt")
    status.must_equal(404)
    headers.must_equal({ 'Content-Length' => response.length.to_s,
      'Content-Type' => 'text/plain' })
    response.must_match(/Not found/)
  end

  it "renders 404 when not set" do
    ENV["DISABLE_ROBOTS"] = nil
    status, headers, response = call("REQUEST_PATH" => "/robots.txt")
    status.must_equal(404)
  end

  it "passes through when robots is not matched" do
    ENV["DISABLE_ROBOTS"] = "true"
    status, headers, response = call("REQUEST_PATH" => "/anything")
    [status, headers, response].must_equal([200, {}, ""])
  end
end
