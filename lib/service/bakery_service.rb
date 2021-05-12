module Service
  class BakeryService
    def self.call(*args, &block)
      new(*args, &block).call
    end
  end
end
