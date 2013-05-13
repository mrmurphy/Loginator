$(document).ready ->

    LOGGEDIN = false
    $('.alert').hide()

    post_error = (msg) ->
        $('.alert').addClass('alert-error')
                   .removeClass('alert-success')
                   .text(msg)
                   .slideDown()

    post_success = (msg) ->
        $('.alert').addClass('alert-success')
                   .removeClass('alert-error')
                   .text(msg)
                   .slideDown()

    to_logged_in_state = (user) ->
        LOGGEDIN = true
        $('.control-group').slideUp()
        $('#button').text('Get me outta here!')
                    .removeClass('btn-primary')
                    .addClass('btn-danger')
        post_success("Welcome back, #{user}! You've been logged in.")
        return

    to_logged_out_state = () ->
        LOGGEDIN = false
        $('.control-group').slideDown()
        $('#button').text('Get me in there!')
                    .removeClass('btn-danger')
                    .addClass('btn-primary')
        $('.alert').slideUp()

    login_fail = () ->
       post_error("Sorry, you're username and/or password are incorrect.")

    process_click = () ->
        if LOGGEDIN
            to_logged_out_state()
            return

        email = $('#email').val()
        password = $('#password').val()

        if not email or not password
            post_error("Oops! Missing an email or a password?")
            return

        $.ajax({
            type: 'GET',
            url: "http://randomlogin.dev/login",
            data: {user: email, pass: password},
            success: (d) -> 
                to_logged_in_state(email)
            error: (xhr, textStatus, errorThrown) -> 
                if errorThrown is 'Unauthorized'
                    login_fail()
                else
                    console.log "The following error was thrown:"
                    console.log errorThrown
            })

    $('#button').click (e) ->
        e.preventDefault()
        process_click()
