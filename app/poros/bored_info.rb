class BoredInfo

  attr_reader :activity, :type, :participants,
              :price

  def initialize(data)
    @activity = data[:activity]
    @type = data[:type]
    @participants = data[:participants]
    @price = data[:price]
  end
end
