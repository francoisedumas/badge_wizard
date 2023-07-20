# frozen_string_literal: true

module LanguageHelper
  def language_options
    {
      en: I18n.t("english"),
      fr: I18n.t("french")
    }.slice(*I18n.available_locales).invert.to_a
  end
end
