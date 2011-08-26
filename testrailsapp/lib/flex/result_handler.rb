module Flex
  class ResultHandler
     VALID_FLEX_RESPONSE_CODES = [422, 404, 401, 400, 201]

     def initialize(app)
       @app = app
     end

     def call(env)
       # if env["QUERY_STRING"] =~ /HTTP_X_FLEX_VERSION/
         @status, @headers, @response = @app.call(env)
         @status = 200 if VALID_FLEX_RESPONSE_CODES.include?(@status)
         [@status, @headers, @response]
       # else
       #   @app.call(env)
       # end
     end

  end
end