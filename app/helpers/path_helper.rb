# frozen_string_literal: true

module PathHelper
  # check if the url is for a new hunter, or a redirect with a hunter object
  def hunter_path?
    current_page?(new_hunter_session_path ||
                  new_hunter_registration_path) || params[:hunter]
  end

  def status_path(inscription)
    ins = inscription
    case ins.status
    when 'pending' then job_path(ins.job)
    when 'rejected' then inscription_rejection_path(ins, ins.rejection)
    when 'approved' then inscription_approval_path(ins, ins.approval)
    end
  end
end
