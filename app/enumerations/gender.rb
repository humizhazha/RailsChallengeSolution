class Gender < EnumerateIt::Base
  associate_values(
      :male,
      :female,
      :other
  )
end
