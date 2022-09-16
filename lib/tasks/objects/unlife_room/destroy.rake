namespace :objects do
  namespace :unlife_room do
    namespace :destroy do
      task :tasks => [
        'objects:unlife_room:destination:mss_objects:delete',
        'objects:unlife_room:destination:mss_objects:drop___cad_quorter',
        'objects:unlife_room:destination:mss_objects:drop___kadastrno',
        'objects:unlife_room:destination:mss_objects_dicts:object:dictionary_land_kvartals:delete',
        'objects:unlife_room:destination:mss_objects_adr:delete',
        'objects:unlife_room:source:ids:drop___link_adr',
        'objects:unlife_room:destination:mss_adr:delete',
      ]
    end
  end
end
