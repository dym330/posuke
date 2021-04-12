class Public::HomesController < ApplicationController
  def top
    @contact = Contact.new
  end
end
