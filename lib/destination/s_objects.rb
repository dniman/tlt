module Destination
  class SObjects

    def self.s_objects
      Destination.s_objects
    end

    def self.obj_id(code)
      Destination.set_engine!

      obj_id = Arel::Nodes::NamedFunction.new("dbo.obj_id", [ Arel::Nodes.build_quoted(code) ])     
      select = Arel::SelectManager.new
      
      query =
        select
        .project(obj_id.as("link"))
      
      Destination.execute_query(query.to_sql).entries.first["link"]
    end

    
  end
end
