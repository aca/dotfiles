if (not (has-env _ENV)) {
  put "env: init"
  set-env _ENV ""
  set-env _OS (uname)
}
