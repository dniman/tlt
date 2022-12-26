namespace :dictionaries do
  namespace :dictionary_bank do
    namespace :source do
      namespace :___client_banks do
        
        task :insert do |t|
          def query
            <<~QUERY
              select 
                isnull((select top 1 isnull(c.bankname, 'Неизвестный банк')
                from clients c
                join (
                  select distinct
                  max(len(isnull(clients.bankname, 'Неизвестный банк'))) as len_name,
                  biks.bik
                  from clients
                  join(
                    select 
                    bik 
                    from clients
                    where bik is not null
                    group by bik
                  ) biks on biks.bik = clients.bik
                  group by biks.bik
                ) banks on banks.bik = c.bik and banks.len_name =len(isnull(c.bankname, 'Неизвестный банк'))
                 where c.bik = clients.bik
                 ), 'Неизвестный банк') as name
                 ,bik
                ,(select top 1 c.corraccount as ks
                from clients c
                join (
                  select distinct
                  max(len(clients.corraccount)) as len_ks,
                  kss.ks
                  from clients
                  join(
                    select 
                    corraccount as ks 
                    from clients
                    where corraccount is not null
                    group by corraccount
                  ) kss on kss.ks = clients.corraccount
                  group by kss.ks
                ) banks on banks.ks = c.corraccount and banks.len_ks =len(c.corraccount)
                 where c.bik = clients.bik) as ks
              from clients
              where bik is not null
              group by bik
            QUERY
          end
          
          begin
            sql = ""
            insert = []
           
            Source.execute_query(query).each_slice(1000) do |rows|
              rows.each do |row|
                insert << {
                  name: row["name"],
                  bic: row["bik"],
                  ks: row["ks"],
                }
              end
              sql = Source::ClientBanks.insert_query(rows: insert, condition: "___client_banks.bic = values_table.bic")
              result = Source.execute_query(sql)
              result.do
              insert.clear
              sql.clear
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
end
