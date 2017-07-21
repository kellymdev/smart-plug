class ImportDataFromFile
  def initialize(plug, data_file)
    @plug = plug
    @data_file = data_file
  end

  def call
    file = File.readlines(@data_file)
    file.each do |line|
      create_reading(line)
    end
  end

  private

  def create_reading(data)
    datetime, consumption, temperature = data.split(';')
    formatted_datetime = format_datetime(datetime)

    if reading = find_reading_for(formatted_datetime)
      reading.update!(
        consumption: consumption.to_i,
        temperature: temperature.to_i
      )
    else
      @plug.readings.create!(
        date_time: formatted_datetime,
        consumption: consumption.to_i,
        temperature: temperature.to_i
      )
    end
  end

  def format_datetime(datetime)
    date = datetime.split(',').join
    DateTime.strptime(date, '%m/%d/%Y %H:%M:%S %p')
  end

  def find_reading_for(datetime)
    @plug.readings.find_by(date_time: datetime)
  end
end
