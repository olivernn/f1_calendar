class BaseMapper
  def self.to_proc
    proc { |h| new(h).to_h }
  end

  def self.provides(*attributes)
    define_method :to_h do
      attributes.each_with_object({}) do |attr_name, h|
        h[attr_name] = send(attr_name)
      end
    end
  end

  def initialize(data = {})
    @data = data
  end

  private

  attr_reader :data
end
