file(REMOVE_RECURSE
  "CMakeFiles/generate-internal-rhel9-all-fixes"
  "checks/sce/metadata.json"
  "collect-remediations-rhel9"
  "product.yml"
  "ssg_build_compile_all-rhel9"
  "templated-content-rhel9"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/generate-internal-rhel9-all-fixes.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
