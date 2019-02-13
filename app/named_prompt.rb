# coding: utf-8
#
module NamedPrompt
  extend AmiVoice::DialogModule::Utility

  class << self
    #
    # Please build your prompt using session object.  The return variable
    # should be String or Array of audio filenames.
    # Here is an example.
    #
    def speech_input_prompts(session)
      session.logger.info("test : #{session[:result]}") 
      session.logger.info("test emp value : #{session[:str_value]} | dep value : #{session[:dep_value]}") 
      if session[:result].blank?
        []
      else 
        if session[:str_value].blank?
          []
        else
          return ["#{session[:title_value]}","#{session[:str_value]}","#{session[:dep_value]}"]
        end
          []
      end
    end

    def speech_transfer_success(session)  
      return ["#{session[:prompt_transfer]}", "#{session[:prompt_emp_value]}", "#{session[:prompt_dep_value]}", "thank_you"] 
    end

  end
end
