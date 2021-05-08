module Product
  class Pack
    attr_reader :name, :code, :packs
    attr_accessor :content

    def initialize(content=0, name, code, packs)
      @content = content
      @name = name
      @code = code
      @packs = packs
    end
  end
  
  class VegemiteScroll < Pack
    def initialize(content=0)
      super(content, "Vegemite Scroll", "VS5", [5, 3])
    end

    def price
      case @content
      when 0
        0.00
      when 3
        6.99
      when 5
        8.99
      else
        raise "#{name} can't be sold in packs of #{@content}!"
      end
    end
  end

  class BlueberryMuffin < Pack
    def initialize(content=0)
      super(content, "Blueberry Muffin", "MB11", [8, 5, 2])
    end

    def price
      case @content
      when 0
        0.00
      when 2
        9.95
      when 5
        16.95
      when 8
        24.95
      else
        raise "#{name} can't be sold in packs of #{@content}!"
      end
    end
  end

  class Croissant < Pack
    def initialize(content=0)
      super(content, "Croissant", "CF", [9, 5, 3])
    end

    def price
      case @content
      when 0
        0.00
      when 3
        5.95
      when 5
        9.95
      when 9
        16.99
      else
        raise "#{name} can't be sold in packs of #{@content}!"
      end
    end
  end
end
