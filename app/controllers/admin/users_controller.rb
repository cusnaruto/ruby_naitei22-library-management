# app/controllers/admin/users_controller.rb
class Admin::UsersController < Admin::ApplicationController
  before_action :set_user, only: %i(show toggle_status)

  # GET /admin/users
  def index
    @pagy, @users = pagy(User.where(role: :user).order_by_created)
  end

  # GET /admin/users/:id
  def show
    @pagy, @borrow_requests = pagy(@user.borrow_requests.sorted)
  end

  # PATCH /admin/users/:id/toggle_status
  def toggle_status
    @user.active? ? @user.inactive! : @user.active!
    respond_to do |format|
      format.html do
        redirect_to admin_users_path,
                    notice: t(".flash.update_success")
      end
      format.turbo_stream
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
    return if @user

    flash[:alert] = t("admin.users.flash.not_found")
    redirect_to users_path
  end

  def user_params
    params.require(:user).permit(:name, :email, :role)
  end
end
