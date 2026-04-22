file(REMOVE_RECURSE
  "../tables/table-rhel9-srgmap-flat.html"
  "../tables/table-rhel9-srgmap.html"
  "CMakeFiles/generate-rhel9-table-srg"
  "checks/sce/metadata.json"
  "product.yml"
  "ssg_build_compile_all-rhel9"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/generate-rhel9-table-srg.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
