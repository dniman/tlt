namespace :corrs do
  namespace :fl_pers do
    namespace :destination do
      namespace :t_corr_note do
        namespace :reference_okved do

          task :delete do |t|
            def query
              condition1 = Destination.t_corr_note.create_on(Destination.s_corr[:link].eq(Destination.t_corr_note[:corr]))
              condition2 = Destination.___del_ids.create_on(
                Destination.___del_ids[:row_id].eq(Destination.s_corr[:row_id])
                .and(Destination.___del_ids[:table_id].eq(Source::Clients.table_id))
              )
              source = Arel::Nodes::JoinSource.new(
                Destination.t_corr_note,[ 
                  Destination.t_corr_note.create_join(Destination.s_corr, condition1),
                  Destination.s_corr.create_join(Destination.___del_ids, condition2)
                ]
              )
              
              manager = Arel::DeleteManager.new Database.destination_engine
              manager.from(source)
              manager.where(Destination.t_corr_note[:object].eq(Destination::TCorrNote::REFERENCE_OKVED))
              manager.to_sql
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
  end
end
