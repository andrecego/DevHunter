# frozen_string_literal: true

module StyleHelper
  def flash_class(level)
    case level
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-danger'
    when 'alert' then 'alert alert-warning'
    end
  end

  def badge(status)
    case status
    when 'pending' then 'warning'
    when 'rejected' then 'danger'
    when 'approved', 'active' then 'info'
    when 'hired' then 'success'
    when 'declined', 'inactive' then 'secondary'
    end
  end
end
