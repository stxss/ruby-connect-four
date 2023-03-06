require_relative "./text_styles"

class Slot
  using TextStyles

  def self.yellow
    "\u{25cf}".fg_color(:yellow)
  end

  def self.blue
    "\u{25cf}".fg_color(:light_blue)
  end

  def self.empty
    "\u{25cb}"
  end
end
