# frozen-string-literal: true

# holds methods for a command
class Command
  def self.execute(*args)
    raise NotImplementedError, 'This method must be implemented in a subclass'
  end
end
