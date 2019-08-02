require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
  	@user = User.new(name: "Example User", email: "user@example.com", password: "minhtuan", password_confirmation: "minhtuan")
  end

  test "should be valide" do
  	assert @user.valid?
  end

  test "name should be presnet" do
  	@user.name = " 	"
  	assert_not @user.valid?
  end

  test "email should be presnet" do
  	@user.email = "  "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = "a" *51
  	assert_not @user.valid?
  end  

  test "email shoudl no be too long" do
  	@user.email = "a" * 244 + "@example.com"
  	assert_not @user.valid?
  end

  test "email validatio shoud accept valid email" do
  	valid_emails = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_emails.each do |valid_email|
    	@user.email = valid_email
    	assert @user.valid?, "#{valid_email.inspect} should be valid"
   	end
  end

  test "email address should be unique" do
  	duplicate_user = @user.dup
  	@user.save
    duplicate_user.email = @user.email.upcase
  	assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "FooBAd@example.com"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be not blank" do
    @user.password = @user.password_confirmation = " " *6
    assert_not @user.valid?
  end

  test "password should have minimum lenght" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end
end
