Dir[File.expand_path('../owner_pay_acc_capital_repair/**/*.rake', __FILE__)].each {|path| import path}

namespace :dictionaries do
  namespace :owner_pay_acc_capital_repair do
    task :import do
      Rake.invoke_task 'dictionaries:owner_pay_acc_capital_repair:destination:mss_objects_dicts:insert'
    end 
    
    task :destroy => [
      'dictionaries:owner_pay_acc_capital_repair:destination:mss_objects_dicts:delete',
    ]
  end
end
