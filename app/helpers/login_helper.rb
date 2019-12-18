# frozen_string_literal: true

module LoginHelper
  # check if the url is for a new hunter, or a redirect with a hunter object
  def hunter_path?
    current_page?(new_hunter_session_path ||
                  new_hunter_registration_path) || params[:hunter]
  end
end
