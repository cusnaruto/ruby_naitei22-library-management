# app/helpers/admin/borrow_requests_helper.rb
module Admin::BorrowRequestsHelper
  STATUS_COLORS = {
    "expired" => "status-expired",
    "cancelled" => "status-cancelled",
    "borrowed" => "status-borrowed",
    "pending" => "status-pending",
    "approved" => "status-approved",
    "rejected" => "status-rejected",
    "returned" => "status-returned",
    "overdue" => "status-overdue"
  }.freeze

  # Returns a formatted date string for the given date.
  def format_date date
    date&.strftime("%-d/%-m/%Y")
  end

  # Returns a CSS class based on the borrow request status.

  def status_colors status
    STATUS_COLORS[status] || "status-default"
  end

  def display_statuses borrow_request
    current_status = borrow_request.status

    allowed_statuses = case current_status.to_sym
                       when :pending
                         %i(approved rejected cancelled)
                       when :approved
                         %i(borrowed)
                       when :overdue
                         %i(returned)
                       when :borrowed
                         %i(returned overdue)
                       else
                         []
                       end

    ([current_status] + allowed_statuses).uniq
  end
end
