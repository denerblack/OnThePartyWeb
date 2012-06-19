module AgnosticRandom
  def random
    case DB_ADAPTER
      when 'mysql' then 'RAND()'
      when 'postgresql' then 'RANDOM()'
    end
  end
end
