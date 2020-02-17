Administrator.create({
  email:      Rails.application.credentials[:admin_email],
  first_name: Rails.application.credentials[:admin_first_name],
  last_name:  Rails.application.credentials[:admin_last_name],
  # Gets encrypted to something like "$2a$12$qQ8DZ7pQTDZViEuke1Ud5OYMrfJ64H9/4Hh2/aj2vt6IqKSzasBOe"
  password:   Rails.application.credentials[:admin_password]
})

User.create({
  email:      'kadeempardue@gmail.com',
  first_name: 'Kadeem',
  last_name:  'Pardue',
  password:   'password123'
})
