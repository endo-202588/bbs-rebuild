ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)
  fixtures :all
end

class ActionDispatch::IntegrationTest
  def login_user(user)
    post login_url, params: {
      user: {                    # ←ここ追加🔥
        email: user.email,
        password: "password"
      }
    }
  end
end
