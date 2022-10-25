namespace :agreements do
  namespace :source do
    namespace :movesets do

      task :update___agreement_id do |t|
        def query1
          <<~SQL
            update movesets  
              set movesets.___agreement_id = ___agreements.id
            from movesets
              join (
              select 
                docset_id,
                coalesce(
                (select t.document_id from docset_members t where t.docrole_id = 1 and t.docset_id = docset_members.docset_id order by id asc offset 0 rows fetch next 1 rows only),
                (select t.document_id from docset_members t where isnull(t.docrole_id, 0) <> 1 and t.docset_id = docset_members.docset_id order by id asc offset 0 rows fetch next 1 rows only)
                ) as document_id
              from docset_members
              group by docset_id
              )t on t.docset_id = movesets.docset_id
              left join ___agreements on ___agreements.document_id = t.document_id and ___agreements.document_id is not null
            where movesets.___agreement_id is null
          SQL
        end

        def query2
          <<~SQL
            update movesets  
              set movesets.___agreement_id = ___agreements.id
            from movesets
              left join ___agreements on cast(___agreements.number as int) = movesets.id and ___agreements.document_id is null
            where movesets.___agreement_id is null
          SQL
        end

        begin
          [ query1, query2 ].each do |query|
            result = Source.execute_query(query)
            result.do
          end
          
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
