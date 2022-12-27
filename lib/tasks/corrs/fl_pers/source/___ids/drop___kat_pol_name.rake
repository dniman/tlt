namespace :corrs do
  namespace :fl_pers do
    namespace :source do
      namespace :___ids do
        
        task :drop___kat_pol_name do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.___ids.name }','___kat_pol_name') is not null)
              alter table #{ Source.___ids.name }
                drop column ___kat_pol_name
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
