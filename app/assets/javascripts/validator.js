$(document)
  .ready(function() {
    $('.ui.form')
      .form({
        fields: {
          first_name: {
            identifier  : 'first_name',
            rules: [
              {
                type   : 'length[2]',
                prompt : 'Your First Name must be at least 2 characters'
              }
            ]
          },
          last_name: {
            identifier  : 'last_name',
            rules: [
              {
                type   : 'length[2]',
                prompt : 'Your Last Name must be at least 2 characters'
              }
            ]
          },
          email: {
            identifier  : 'email',
            rules: [
              {
                type   : 'email',
                prompt : 'Your Email address must be valid'
              }
            ]
          },
          password: {
            identifier  : 'password',
            rules: [
              {
                type   : 'length[6]',
                prompt : 'Your Password must be at least 6 characters'
              }
            ]
          }
        }
      })
    ;
  })
;
