namespace :paycards do
  namespace :destination do
    namespace :paycard do

      task :admin_fk_enable do |t|
        def query
          <<~QUERY
            exec admin_fk 'enable', 'paycard' 
          QUERY
        end

        begin
          Destination.execute_query(query).do
          
          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ query }\""

          exit
        end
      end

    end
  end
end
