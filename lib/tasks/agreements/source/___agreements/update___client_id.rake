namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___client_id do |t|

        def query
          <<~QUERY
            update ___agreements
              set ___agreements.___client_id = movesets.___client_id
            from ___agreements
              join movesets on movesets.___agreement_id = ___agreements.id
          QUERY
        end

        begin
          Source.execute_query(query).do
          
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
