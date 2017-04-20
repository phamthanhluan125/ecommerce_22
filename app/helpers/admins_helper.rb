module AdminsHelper
  def load_select
    data = [[t("7_day"), 0],[t("10_day"), 1], [t("30_day"),2]]
    return select_tag t("choose_type"), options_for_select(data)
    binding.pry
  end
end
