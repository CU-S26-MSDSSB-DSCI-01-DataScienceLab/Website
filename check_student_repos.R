library(ghclass) # For managing the GitHub organization
library(tidyverse)
library(glue)
orgname <- "CU-S26-MSDSSB-DSCI-01-DataScienceLab"

clone_or_pull_student_repos <- function(
  prefix,
  local_student_repo_path = "../StudentRepos/"
) {
  localfiles <- dir(glue("{local_student_repo_path}{prefix}/"))
  localrepos <- sort(glue("{orgname}/{localfiles}"))
  if (prefix == "FinalProject") {
    remoterepos <- sort(org_repos(orgname, glue("{prefix}_")))
  } else {
    remoterepos <-
      sort(
        org_repos(orgname, glue("{prefix}_")) |>
          discard(~ any(str_detect(., "FinalProject_")))
      )
  }
  to_clone <- setdiff(remoterepos, localrepos)
  local_repo_clone(
    repo = to_clone,
    local_path = glue("{local_student_repo_path}{prefix}/")
  )
  local_repo_pull(
    repo = paste0(local_student_repo_path, prefix, "/", localfiles)
  )
}

clone_or_pull_student_repos("DataScienceLab")

## Delete one repo
# repo_delete("CU-F25-MDSSB-01-Concepts-Tools/Project_COVID19_Armin")
