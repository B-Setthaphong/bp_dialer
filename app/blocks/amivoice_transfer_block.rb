 class AmivoiceTransferBlock < AmiVoice::DialogModule::BlockBase
   
  class << self

    amivoice_transfer_prompts = 'please_say_your_message'

    def get_attach_data prompt_transfer 
      puts prompt_transfer  
      transfer_data = {} 
      transfer_data['QA'] = prompt_transfer  
    end

    define_method :amivoice_transfer_prompts= do |prompts|
      amivoice_transfer_prompts = prompts
    end 
    define_method :amivoice_transfer_prompts do
      amivoice_transfer_prompts
    end

  end
end
