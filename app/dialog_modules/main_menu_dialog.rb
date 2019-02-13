class MainMenuDialog < ApplicationBaseDialog

  description <<-"DESCRIPTION"
    TODO: Explain this dialog module briefly
  DESCRIPTION

  #
  #== Prompts
  #
  init1         ['welcome_to_amivoicethai',
                 'to_employee'] 

  retry1        ['sorry_i_cannot_understand_you',
                 'can_you_say_again']
  retry2        ['sorry_i_cannot_understand_you_again',
                 'can_you_say_again']

  timeout1      ['sorry_i_cannot_hear_you',
                 'can_you_say_again']
  timeout2      ['sorry_i_cannot_hear_you_again',
                 'can_you_say_again']

  reject1       ['sorry_i_cannot_understand_you','can_you_say_again']
  reject2       ['sorry_i_cannot_understand_you','can_you_say_again']

  confirmation_init1    ['calling_to_who', '%speech_input_prompts%','is_it_correct']
  confirmation_retry1   ['sorry_i_cannot_understand_you',
                         '%speech_input_prompts%','is_it_correct']
  confirmation_reject1   ['%speech_input_prompts%','is_it_correct']
  confirmation_timeout1 ['sorry_i_cannot_hear_you',
                         '%speech_input_prompts%','is_it_correct']

  #
  #== Properties
  #
  grammar_name           "amivoice.gram" # TODO: Please set your grammar
  confidence_level 0.2
  max_retry 3
  confirmation_method    :server

  #
  #==Action
  #


#  before_generate_vxml do |session, params|
#    session.logger.info("before_generate_vxml")
#  end

#
# When you want to write your own rule for confirmation, you can
# change confirmation_method :server and uncomment below.
#
  confirmation_method_server do |session, params|
    session.logger.info("confirmation_method_server")
    result       = ""
    prompt_retry = []
    prompts      = []
    group_caller = params["result"].split(":").last
    spi_value    = params["result"].split(":").first  

    prompts = self::caller_group_function(session, group_caller, spi_value)  
    if prompts.length == 2
      result        = prompts[0]
      prompt_retry  = [prompts[1]]
    elsif prompts.length == 3
      result                  = prompts[0] 
      session["title_value"]  = prompts[1]
      session["str_value"]    = prompts[2] 
    elsif prompts.length == 4
      result                  = prompts[0] 
      session["title_value"]  = prompts[1]
      session["str_value"]    = prompts[2]
      session["dep_value"]    = prompts[3]
    end
    # rd          = %w{6 7 8 9}
    # transcriber = %w{16 17 18}
    # development = %w{4 5 10 11 12 13 15 19 20 21 22 23 24 25 26}
    # finance     = %w{1}
    # accounting  = %w{1}
    # sales       = %w{2 3}
    # hr          = %w{1}
    # admin       = %w{1} 
    # management  = %w{14} 

    # session.logger.info("test : #{params["result"]}") 

    # str_dep = "";
    # str_emp1 = "";
    # str_emp2 = "";
    # params["result"].split("-").each do |result|
    #   if (/dep/.match(result))
    #     str_dep = result.split("=").last
    #   elsif (/emp/.match(result) && str_emp1.empty?)
    #     str_emp1 = result.split("=").last
    #   elsif (/emp/.match(result) && !str_emp1.empty?)
    #     str_emp2 = result.split("=").last
    #   end
    # end
    # session.logger.info("dep : #{str_dep} | emp1 : #{str_emp1} | emp2 : #{str_emp2}")

    # if(str_emp1.eql?(str_emp2) && !str_emp1.empty? && !str_emp2.empty? && str_dep.empty?) 
    #   session.logger.info("1")
    #   session["str_value"]    = "emp_"+str_emp1
    #   result = "confirm"
    #   prompt_retry = []
    # elsif(!str_emp1.empty? && str_emp2.empty? && str_dep.empty?) 
    #   session.logger.info("2")
    #   session["str_value"]    = "emp_"+str_emp1
    #   result = "confirm"
    #   prompt_retry = []
    # elsif(!str_dep.empty? && str_emp1.empty? && str_emp2.empty?) 
    #   session.logger.info("3")
    #   session["dep_value"]    = str_dep.downcase  
    #   result = "confirm"
    #   prompt_retry = []
    # elsif(!str_emp1.empty? && str_emp2.empty? && !str_dep.empty?) 
    #   session.logger.info("4")
    #   if ((rd.include? str_emp1) && (str_dep == "rd")) || ((transcriber.include? str_emp1) && (str_dep == "Transcriber")) ||
    #     ((development.include? str_emp1) && (str_dep == "Development")) || ((finance.include? str_emp1) && (str_dep == "Finance")) ||
    #     ((accounting.include? str_emp1) && (str_dep == "Accounting")) || ((sales.include? str_emp1) && (str_dep == "Sales")) ||
    #     ((hr.include? str_emp1) && (str_dep == "Hr")) || ((admin.include? str_emp1) && (str_dep == "Admin")) ||
    #     ((management.include? str_emp1) && (str_dep == "Management"))
    #     session["str_value"]    = "emp_"+str_emp1
    #     session["dep_value"]    = str_dep.downcase  
    #     result = "confirm" 
    #     prompt_retry = []
    #   else
    #     result = "reject"
    #     prompt_retry = ["no_dep_matching"]
    #   end 
    # elsif(str_emp1.eql?(str_emp2) && !str_emp1.empty? && !str_emp2.empty? && !str_dep.empty?)   
    #   session.logger.info("5")
    #   if ((rd.include? str_emp1) && (str_dep == "rd")) || ((transcriber.include? str_emp1) && (str_dep == "Transcriber")) ||
    #     ((development.include? str_emp1) && (str_dep == "Development")) || ((finance.include? str_emp1) && (str_dep == "Finance")) ||
    #     ((accounting.include? str_emp1) && (str_dep == "Accounting")) || ((sales.include? str_emp1) && (str_dep == "Sales")) ||
    #     ((hr.include? str_emp1) && (str_dep == "Hr")) || ((admin.include? str_emp1) && (str_dep == "Admin")) ||
    #     ((management.include? str_emp1) && (str_dep == "Management"))
    #     session["str_value"]    = "emp_"+str_emp1
    #     session["dep_value"]    = str_dep.downcase  
    #     result = "confirm" 
    #     prompt_retry = []
    #   else
    #     result = "reject"
    #     prompt_retry = ["no_dep_matching"]
    #   end  
    # else
    #   result = "reject"
    #   prompt_retry = ["no_matching"]
    # end 
    [result, prompt_retry]
  end

  # before_confirmation do |session, params|
  #   session.logger.info("before_confirmation")
  # end

  action do |session|
    # TODO: Please describe action here and set appropriate next dialog.
    # The last value should be next dialog.  But note that this block does not allow
    # to use 'return'.
    session.logger.info("action") 

    session.logger.info(session["result"])
    if (session["result"] == "failure")
      session.logger.info("action is failure") 
      #TransferToAgentBlock
    else
      spi_value = session["result"].split(":").first  
      str_name  = spi_value.split("-")
      if (session["result"].split(":").last  == 'grp=1' || session["result"].split(":").last  == 'grp=2') 
        session["prompt_transfer"] = "transfer_to_emp"
        session["prompt_emp_value"]    = str_name[1].sub("=","_")
      elsif (session["result"].split(":").last  == 'grp=3') 
        session["prompt_transfer"] = "transfer_to_dep"
        session["prompt_dep_value"]    = str_name[1].downcase.split("=").last
      elsif (session["result"].split(":").last  == 'grp=5' || session["result"].split(":").last  == 'grp=8')
        session["prompt_transfer"] = "transfer_to_emp" 
        session["prompt_emp_value"] = str_name[1].sub("=","_") 
        session["prompt_dep_value"] = str_name[2].downcase
      elsif (session["result"].split(":").last  == 'grp=6' || session["result"].split(":").last  == 'grp=9')
        session["prompt_transfer"] = "transfer_to_emp"
        session["prompt_dep_value"] = str_name[1].downcase
        session["prompt_emp_value"] = str_name[2].sub("=","_")
      elsif (session["result"].split(":").last  == 'grp=7')
        session["prompt_transfer"] = "transfer_to_emp"
        session["prompt_emp_value"] = str_name[1].sub("=","_")
        session["prompt_dep_value"] = str_name[3].downcase 
      end
      #TransferBlock
      AmivoiceTransferBlock::get_attach_data session['prompt_transfer']
      session.logger.info(session["prompt_transfer"])
      session.logger.info(session["prompt_emp_value"])
      session.logger.info(session["prompt_dep_value"])  
      AmivoiceTransferBlock
    end
  end

#  ending do |session, params|
#    session.logger.info("ending")
#  end    
  def self.caller_group_function(session, group_caller, spi_value) 
    result_type = ""
    # ----- begin case 
    case group_caller 
    # ----- begin when 
    when 'grp=1', 'grp=2', 'grp=3'
      title_value = spi_value.split("-").first
      str_value   = spi_value.split("-").last 
      result_type = "confirm"  
      if group_caller.eql?("grp=3") 
        str_value = str_value.sub("dep=", "").downcase
      else
        str_value = str_value.sub("=", "_") 
      end 
      if /title/.match(spi_value)  
        ar_prompt = [result_type, title_value.sub("=", "_"), str_value]
      else   
        if group_caller.eql?("grp=3")
          title_value = "title_7"
        else
          title_value = "title_1"
        end 
        ar_prompt = [result_type, title_value, str_value]
      end  
    # ----- end when
    when 'grp=4'  
      title_value      = ""
      str_name         = spi_value.split("-")
      if /title/.match(spi_value)
        title_value    = str_name[0].split("=").last
        title_value    = "title_#{title_value}"  
      else
        title_value    = ""   
      end 
      emp_nick_value = str_name[1].split("=").last
      emp_name_value = str_name[2].split("=").last 
      if emp_name_value.eql?(emp_nick_value)  
        result_type = "confirm" 
        ar_prompt   = [result_type, title_value, "emp_#{emp_name_value}"]
      else
        result_type = "reject" 
        ar_prompt = [result_type, "no_matching"]
      end
    # ----- end when  
    when 'grp=5', 'grp=6'
      title_value       = ""
      str_name          = spi_value.split("-")
      if /title/.match(spi_value)
        #title_value       = spi_value.split("-").first  
        title_value    = str_name[0].split("=").last
        title_value    = "title_#{title_value}" 
      else
        title_value    = ""
      end  
      if group_caller.eql?('grp=5')
        number_name = 1
        number_dept = 2
      elsif group_caller.eql?('grp=6')
        number_name = 2 
        number_dept = 1 
      end 
      
      emp_name_value    = str_name[number_name].split("=").last
      department_value  = str_name[number_dept].split("=").last 
      session.logger.info("emp : #{number_name} : dep #{number_dept}")
      session.logger.info("emp : #{emp_name_value} : dep #{department_value}")
       
      ar_prompt = self::department_function(title_value, emp_name_value, department_value) 
    # ----- end when   
    when 'grp=7', 'grp=8', 'grp=9'
      title_value      = ""
      str_name         = spi_value.split("-")
      if /title/.match(spi_value)
        title_value    = str_name[0].split("=").last
        title_value    = "title_#{title_value}"  
        if group_caller.eql?('grp=7')
          number_name = 2
          number_nick = 1
          number_dept = 3
        elsif group_caller.eql?('grp=8')
          number_name = 1
          number_nick = 3
          number_dept = 2
        elsif group_caller.eql?('grp=9')
          number_name = 3
          number_nick = 2
          number_dept = 1
        end
      else
        title_value    = ""  
        if group_caller.eql?('grp=7')
          number_name = 1
          number_nick = 0
          number_dept = 2
        elsif group_caller.eql?('grp=8')
          number_name = 0
          number_nick = 2
          number_dept = 1
        elsif group_caller.eql?('grp=9')
          number_name = 2
          number_nick = 1
          number_dept = 0
        end
      end  
       
      emp_nick_value    = str_name[number_nick].split("=").last
      emp_name_value    = str_name[number_name].split("=").last 
      department_value  = str_name[number_dept].split("=").last 
      if emp_name_value.eql?(emp_nick_value)    
        ar_prompt = self::department_function(title_value, emp_name_value, department_value)
      else
        result_type = "reject" 
        ar_prompt = [result_type, "no_matching"]
      end
    # ----- end when 

    end
    # ----- end case
    return ar_prompt
  end 

  def self.department_function(title_value, emp_name_value, department_value) 
    rd          = %w{6 7 8 9}
    transcriber = %w{16 17 18}
    development = %w{4 5 10 11 12 13 15 19 20 21 22 23 24 25 26}
    finance     = %w{1}
    accounting  = %w{1}
    sales       = %w{2 3}
    hr          = %w{1}
    admin       = %w{1}
    management  = %w{14}
    result_type = "confirm" 
    if (rd.include? emp_name_value) && (department_value == "rd")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "rd"]  
    elsif (transcriber.include? emp_name_value) && (department_value == "Transcriber")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "transcriber"]
    elsif (development.include? emp_name_value) && (department_value == "Development")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "development"] 
    elsif (finance.include? emp_name_value) && (department_value == "Finance")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "finance"]
    elsif (accounting.include? emp_name_value) && (department_value == "Accounting")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "accounting"]
    elsif (sales.include? emp_name_value) && (department_value == "Sales")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "sales"]
    elsif (hr.include? emp_name_value) && (department_value == "Hr")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "hr"]
    elsif (admin.include? emp_name_value) && (department_value == "Admin")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "admin"] 
    elsif (admin.include? emp_name_value) && (department_value == "Management")
      ar_prompt = [result_type, title_value, "emp_#{emp_name_value}", "management"] 
    else
      result_type = "reject" 
      ar_prompt = [result_type, "no_matching"]
    end 
    return ar_prompt
  end

end
