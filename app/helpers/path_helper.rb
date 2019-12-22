# frozen_string_literal: true

module PathHelper
  # check if the url is for a new hunter, or a redirect with a hunter object
  def hunter_path?
    current_page?(new_hunter_session_path ||
                  new_hunter_registration_path) || params[:hunter]
  end

  def status_path(status)
    case status
    when 'rejected' then return inscription_rejection_path(@inscription, 1)
    return false
    end
  end
end