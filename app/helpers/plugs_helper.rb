module PlugsHelper
  def displayable_date_time(date_time)
    date_time.strftime('%d-%m-%Y %H:%M')
  end
end