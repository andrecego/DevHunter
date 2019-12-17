# frozen_string_literal: true

module TranslationHelper
  def enum_translate(type, enum, value)
    t("activerecord.attributes.#{type}.#{enum}.#{value}")
  end
end
