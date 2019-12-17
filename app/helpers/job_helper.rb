# frozen_string_literal: true

module JobHelper
  def job_attribute_positions_hash
    Hash[Job.positions.map do |k, _v|
           [k.to_sym, t("activerecord.attributes.job.positions.#{k}")]
         end ]
  end
end
