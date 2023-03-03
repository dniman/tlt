namespace :paycards do
  namespace :destination do
    namespace :schedulesum do
      task :insert do |t|
        def query
          <<~QUERY
            select
              ___ids.link, 
              ___paycards.summa2 as summa, 
              ___paycards.summa2 as summa_prc, 
              ___paycards.sincedate as date_b,   
              case when 
                ___name_type_a like '%купля-продажа% 
              then case when ___paycards.date_f_pay is null then null else dateadd(day, -1, ___paycards.date_f_pay) end
              else case when ___paycads.date_f is null then null else dateadd(day, -1, ___paycards.date_f) end
              end as rdate,
              case when 
                ___name_type_a like '%купля-продажа% 
              then case when ___paycards.date_f_pay is null then null else dateadd(day, -1, ___paycards.date_f_pay) end
              else case when ___paycads.date_f is null then null else dateadd(day, -1, ___paycards.date_f) end
              end as date_exec
            from ___paycards
              join ___ids on ___ids.id = ___paycards.id and table_id = object_id('___paycards')
            where ___paycards.___name_type_a not like 'Неосновательное обогащение%' and ___name_objtype = 'Земельные участки'
          QUERY
        end

        begin
          sql = ""
          selects = [] 
          unions = []
          
          Source.execute_query(query.to_sql).each_slice(1000) do |rows|
            rows.each do |row|
              Arel::SelectManager.new.tap do |select|
                selects <<
                  select.project([
                    Arel::Nodes::Quoted.new(row["link_pc"]),
                    Arel::Nodes::Quoted.new(row["summa"]),
                    Arel::Nodes::Quoted.new(row["summa_prc"]),
                    Arel::Nodes::Quoted.new(row["date_b"]),
                    Arel::Nodes::Quoted.new(row["rdate"]),
                    Arel::Nodes::Quoted.new(row["date_exec"]),
                  ])
              end
            end  
            unions << Arel::Nodes::UnionAll.new(selects[0], selects[1])
            selects[2..-1].each do |select| 
              unions << Arel::Nodes::UnionAll.new(unions.last, select)
            end
            insert_manager = Arel::InsertManager.new(Database.destination_engine).tap do |manager|
              rows.first.keys.each do |column|
                manager.columns << Destination.schedulesum[column.to_sym]
              end
              manager.into(Destination.schedulesum)
              manager.select(unions.last)
            end
            sql = insert_manager.to_sql
          
            result = Destination.execute_query(sql)
            result.do
            selects.clear
            unions.clear
            sql.clear
        end
      end

    end
  end
end
