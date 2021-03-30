function os.clr
  # set -e OS_AUTH_URL
  # set -e OS_IDENTITY_API_VERSION
  # set -e OS_PASSWORD
  # set -e OS_PROJECT_DOMAIN_NAME
  # set -e OS_PROJECT_NAME
  # set -e OS_REGION_NAME
  # set -e OS_SERVICE_TOKEN
  # set -e OS_USERNAME
  # set -e OS_USER_DOMAIN_NAME

  for v in (set -x  | grep OS_ | awk '{print $1}')
    set -e $v
  end
end
