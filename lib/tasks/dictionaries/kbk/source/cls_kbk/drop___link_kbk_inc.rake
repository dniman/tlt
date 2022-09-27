namespace :dictionaries do
  namespace :kbk do
    namespace :source do
      namespace :cls_kbk do
        
        task :drop___link_kbk_inc do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.cls_kbk.name }','___link_kbk_inc') is not null)
              alter table #{ Source.cls_kbk.name }
                drop column ___link_kbk_inc
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
