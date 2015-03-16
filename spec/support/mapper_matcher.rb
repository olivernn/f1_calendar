RSpec::Matchers.define :provide_attributes do |attrs|
  match do |mapper|
    actual = mapper.to_h

    attrs.all? do |key, value|
      actual[key] == value
    end
  end
end
