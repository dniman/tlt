namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___transferbasis_name do |t|

        def query
          Source.movesets
          .project(
            Source.movesets[:___agreement_id],
            Source.transferbasis[:name].as("___transferbasis_name"),
          )
          .distinct
          .join(Source.movetype).on(Source.movetype[:id].eq(Source.movesets[:movetype_id]))
          .join(Source.transferbasis).on(Source.transferbasis[:id].eq(Source.movesets[:transferbasis_id]))
        end

        begin
          sql = <<~SQL
            update ___agreements set 
              ___agreements.___transferbasis_name = values_table.___transferbasis_name
            from ___agreements
              join(
                #{ query.to_sql }
              ) values_table(___agreement_id, ___transferbasis_name) on values_table.___agreement_id = ___agreements.id
          SQL
              
          Source.execute_query(sql).do
          
          Rake.info "Задача '#{ t }' успешно выполнена."
        rescue StandardError => e
          Rake.error "Ошибка при выполнении задачи '#{ t }' - #{e}."
          Rake.info "Текст запроса \"#{ sql }\""

          exit
        end
      end

    end
  end
end
