module LanguageHelper
  LANGUAGES = {
    en: I18n.t("english"),
    fr: I18n.t("french")
  }

  def language_options
    LANGUAGES.slice(*I18n.available_locales).invert.to_a
  end
end
