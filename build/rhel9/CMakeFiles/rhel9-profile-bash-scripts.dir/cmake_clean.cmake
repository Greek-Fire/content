file(REMOVE_RECURSE
  "../bash/all-profile-bash-scripts-rhel9"
  "../ssg-rhel9-cpe-dictionary.xml"
  "../ssg-rhel9-cpe-oval.xml"
  "../ssg-rhel9-ds.xml"
  "../ssg-rhel9-ocil.xml"
  "../ssg-rhel9-oval.xml"
  "../ssg-rhel9-xccdf.xml"
  "CMakeFiles/rhel9-profile-bash-scripts"
  "checks/sce/metadata.json"
  "collect-remediations-rhel9"
  "cpe-oval-unlinked.xml"
  "oval-unlinked.xml"
  "product.yml"
  "ssg-rhel9-ocil.xml"
  "ssg-rhel9-oval.xml"
  "ssg-rhel9-xccdf.xml"
  "ssg_build_compile_all-rhel9"
  "templated-content-rhel9"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/rhel9-profile-bash-scripts.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
