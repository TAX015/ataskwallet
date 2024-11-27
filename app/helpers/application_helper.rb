module ApplicationHelper
  def bootstrap_class_for_flash(flash_type)
    case flash_type.to_sym
    when :notice
      "success"
    when :alert, :error
      "danger"
    else
      "info"
    end
  end

  def to_currency number, unit="", precision=0
    number_to_currency(number, :unit => unit, :precision => precision, :separator => ",", :delimiter => ".")
  end
end
