class CarImport::Validators::RowValidator
  include Virtus.model(strict: true)
  attribute :line, Integer
  attribute :row, Hash
  attribute :car_object, Car, default: :init_object

  def on_success(&block)
    self.on_success_cb = block
    execute?
  end

  def on_error(&block)
    self.on_error_cb = block
    execute?
  end

  private

    attr_accessor :record, :validation, :on_success_cb, :on_error_cb

    def execute?
      if on_error_cb && on_success_cb
        if car_object.valid?
          on_success_cb.call(data_object)
        else
          on_error_cb.call(error_object(car_object.errors.messages))
        end
      end
    end

    def data_object
      CarImport::Dtos::CarData.new(
        id: row["id"],
        manufacturer: row["manufacturer"],
        price: BigDecimal.new(row["price"]),
        used: row["used"],
        note: row["note"]
      )
    end

    def error_object(messages)
      CarImport::Dtos::ErrorData.new(
        line: line,
        messages: messages
      )
    end

    def init_object
      Car.new(row)
    end

end
