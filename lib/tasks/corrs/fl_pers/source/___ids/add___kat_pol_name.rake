namespace :corrs do
  namespace :fl_pers do
    namespace :source do
      namespace :___ids do

        task :add___kat_pol_name do |t|
          begin
            sql = Arel.sql(
              "alter table #{ Source.___ids.name }
                add ___kat_pol_name varchar(300) 
              "
            )
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
end