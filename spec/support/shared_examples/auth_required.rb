RSpec.shared_examples "ログイン必須" do
  it "ログイン画面にリダイレクトされる" do
    subject
    expect(response).to redirect_to(login_path)
  end
end
