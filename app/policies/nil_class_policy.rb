class NilClassPolicy < ApplicationPolicy

    # Nobody can see nothing.
    def show?
      false
    end
  
  end
  