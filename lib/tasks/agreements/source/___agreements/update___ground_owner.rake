namespace :agreements do
  namespace :source do
    namespace :___agreements do

      task :update___ground_owner do |t|

        def query
          Source.movesets
          .project(
            Source.movesets[:___agreement_id],
            Source.movesets[:___ground_owner],
          )
          .distinct
          .join(Source.___agreements).on(Source.___agreements[:id].eq(Source.movesets[:___agreement_id]))
          .where(Source.___agreements[:___ground_owner_count].eq(1))
        end

        begin
          sql = <<~SQL
            update ___agreements set 
              ___agreements.___ground_owner = values_table.___ground_owner
            from ___agreements
              join(
                #{ query.to_sql }
              ) values_table(___agreement_id, ___ground_owner) on values_table.___agreement_id = ___agreements.id
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
