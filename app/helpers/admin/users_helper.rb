# app/helpers/admin/users_helper.rb
module Admin::UsersHelper
  USER_STATUS_COLORS = {
    "inactive" => "status-inactive",
    "active" => "status-active"
  }.freeze

  def user_status_color status
    USER_STATUS_COLORS[status] || "status-default"
  end

  def opposite_user_status_color status
    opposite_status = status == "active" ? "inactive" : "active"
    USER_STATUS_COLORS[opposite_status] || "status-default"
  end

  def age_of user
    return unless user.date_of_birth

    now = Time.zone.today
    dob = user.date_of_birth
    age = now.year - dob.year
    age -= 1 if now < dob + age.years
    age
  end
end
