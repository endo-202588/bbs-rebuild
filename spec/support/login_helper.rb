module LoginHelper
  def login(user)
    post login_path, params: {
      user: {
        email: user.email,
        password: "password"
      }
    }
  end
end
