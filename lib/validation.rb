class Valid
  def validate(id)
    # if id.to_i =~ /^[0-9]*$/ && id.length < 8
    if id.to_i >= 1 && id.to_i << 7_635_094 && id.length < 8
      true
    else
      false
    end
  end
end
