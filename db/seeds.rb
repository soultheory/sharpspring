Administrator.create({
  email: Rails.application.credentials[:admin_email],
  first_name: Rails.application.credentials[:admin_first_name],
  last_name: Rails.application.credentials[:admin_last_name],
  password: Rails.application.credentials[:admin_password] # gets encrypted
})
