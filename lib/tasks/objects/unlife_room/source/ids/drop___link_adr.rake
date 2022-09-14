namespace :objects do
  namespace :unlife_room do
    namespace :source do
      namespace :ids do

        task :drop___link_adr do |t|
          begin
            sql = Arel.sql(
              "if (col_length('#{ Source.ids.name }','___link_adr') is not null)
              alter table #{ Source.ids.name }
                drop column ___link_adr
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
