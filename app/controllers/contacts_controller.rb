class ContactsController < ApplicationController
  
  def new
       @title = "Contact"
        @header = 'contact'
        @no_lhn = true
        @span = 'span_12'
      @contact = Contact.new
    end

    def create
      @contact = Contact.new(params[:contact])
      @contact.request = request
      if @contact.deliver
           redirect_to contact_path, notice: I18n.t('contact_success')
      else
           redirect_to contact_path, :flash => { :error => I18n.t('contact_error') }
      end
    end
  
  
end
