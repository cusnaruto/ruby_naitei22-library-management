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
end
