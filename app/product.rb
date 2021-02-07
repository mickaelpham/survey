class Product
  ATTRIBUTES = %i[
    id
    name
    description
  ].freeze

  class << self
    def all
      Database.conn.exec('SELECT * FROM product') do |exec_result|
        exec_result.each_with_object([]) do |row, result|
          result << create_from_db(row)
        end
      end
    end

    def create_from_db(row)
      new.tap do |instance|
        ATTRIBUTES.each do |attr|
          instance.public_send(:"#{attr}=", row[attr.to_s])
        end
      end
    end
  end

  ATTRIBUTES.each do |attr|
    attr_accessor(attr)
  end

  def to_h
    ATTRIBUTES.each_with_object({}) do |attr, result|
      result[attr] = send(attr)
    end
  end
end
